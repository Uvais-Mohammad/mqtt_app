import 'package:mqtt_app/features/ac/models/air_condition_model.dart';
import 'package:mqtt_client/mqtt_client.dart';

abstract interface class IAirConditionRepository {
  Future<void> subscribeToAirConditionData();
  AirConditionModel getAirConditionData(List<MqttReceivedMessage<MqttMessage>> data);
  Future<void> publishTemperature(AirConditionModel data);
}