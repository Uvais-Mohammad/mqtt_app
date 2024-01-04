import 'package:get_it/get_it.dart';
import 'package:mqtt_app/features/ac/repository/ac_repository.dart';
import 'package:mqtt_app/features/ac/repository/i_ac_repository.dart';
import 'package:mqtt_app/shared/services/i_mqtt_service.dart';
import 'package:mqtt_app/shared/services/mqtt_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  locator
    ..registerLazySingleton<IMqttService>(() => MqttService())
    ..registerLazySingleton<IAirConditionRepository>(
        () => AirConditionRepository(mqttService: locator<IMqttService>()));
}
