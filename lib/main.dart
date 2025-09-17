import 'dart:async';

import 'package:currency_converter/repository/currensies/models/currency_details.dart';
import 'package:currency_converter/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/currensies/currency.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'router/router.dart';
import 'package:hive_flutter/hive_flutter.dart';

const currenciesBoxName = 'currencies_box';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Started');

   await Hive.initFlutter();

   Hive.registerAdapter(CurrencyAdapter());
   Hive.registerAdapter(CurrencyDetailsAdapter());

   final currenciesBox = await Hive.openBox<Currency>(currenciesBoxName);

  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(talker: talker));

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );
  
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  GetIt.I.registerLazySingleton<AbstractCurrencyRepository>(
          () => CurrencyRepository(
            dio: dio,
            currenciesBox: currenciesBox
          )
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
    () => runApp(const CurrencyConventerApp()), 
    (e, st) => GetIt.I<Talker>().handle(e, st)
  );
}

class CurrencyConventerApp extends StatelessWidget {
  const CurrencyConventerApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrencyApp',
      theme: privateTheme,
      routes: router,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.I<Talker>())
      ],
    );
  }
}


