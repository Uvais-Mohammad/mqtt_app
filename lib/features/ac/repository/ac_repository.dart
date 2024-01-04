import 'dart:convert';

import 'package:mqtt_app/features/ac/models/air_condition_model.dart';
import 'package:mqtt_app/features/ac/repository/i_ac_repository.dart';
import 'package:mqtt_app/shared/services/i_mqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';

final class AirConditionRepository implements IAirConditionRepository {
  final IMqttService _mqttService;

  AirConditionRepository({
    required IMqttService mqttService,
  }) : _mqttService = mqttService;

  @override
  AirConditionModel getAirConditionData(
      List<MqttReceivedMessage<MqttMessage>> data) {
    final recMess = data[0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    Map<String, dynamic> json = jsonDecode(pt);
    return AirConditionModel.fromJson(json);
  }

  @override
  Future<void> publishTemperature(AirConditionModel data) async {
    return _mqttService.publish(
      'air_condition/data',
      jsonEncode(data.toJson()),
    );
  }

  @override
  Future<void> subscribeToAirConditionData() async {
    return _mqttService.subscribe('air_condition/data');
  }
}
