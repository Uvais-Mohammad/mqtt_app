
import 'package:get_it/get_it.dart';
import 'package:mqtt_app/shared/services/i_mqtt_service.dart';
import 'package:mqtt_app/shared/services/mqtt_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<IMqttService>(() => MqttService());
}