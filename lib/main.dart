import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/features/ac/logic/air_condition/air_condition_bloc.dart';
import 'package:mqtt_app/features/ac/repository/i_ac_repository.dart';
import 'package:mqtt_app/features/splash/screens/splash_screen.dart';
import 'package:mqtt_app/service_locator.dart';
import 'package:mqtt_app/shared/services/i_mqtt_service.dart';
import 'package:mqtt_app/shared/themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await locator<IMqttService>().connect();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AirConditionBloc(
            mqttService: locator<IMqttService>(),
            airConditionRepository: locator<IAirConditionRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: appTheme,
      ),
    ),
  );
}
