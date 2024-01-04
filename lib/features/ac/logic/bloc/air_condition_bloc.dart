import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/shared/services/i_mqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';

part 'air_condition_event.dart';
part 'air_condition_state.dart';

class AirConditionBloc extends Bloc<AirConditionEvent, AirConditionState> {
  AirConditionBloc({
    required IMqttService mqttService,
  })  : _mqttService = mqttService,
        super(const AirConditionState()) {
    on<AirConditionDataRequested>(_onDataRequested);
  }

  final IMqttService _mqttService;

  void _onDataRequested(
    AirConditionDataRequested event,
    Emitter<AirConditionState> emit,
  ) async {
    await _mqttService.connect();
    await _mqttService.subscribe('air_condition/data');
    await emit.forEach(
      _mqttService.dataReceived,
      onData: (data) {
        final recMess = data[0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        Map<String, dynamic> json = jsonDecode(pt);
        return state.copyWith(
          temperature: json['temperature'],
          humidity: json['humidity'],
          windSpeed: json['windSpeed'],
        );
      },
    );
  }
}
