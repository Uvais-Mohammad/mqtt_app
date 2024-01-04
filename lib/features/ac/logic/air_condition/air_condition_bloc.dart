import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/features/ac/models/air_condition_model.dart';
import 'package:mqtt_app/features/ac/repository/i_ac_repository.dart';
import 'package:mqtt_app/shared/services/i_mqtt_service.dart';

part 'air_condition_event.dart';
part 'air_condition_state.dart';

class AirConditionBloc extends Bloc<AirConditionEvent, AirConditionState> {
  AirConditionBloc({
    required IMqttService mqttService,
    required IAirConditionRepository airConditionRepository,
  })  : _mqttService = mqttService,
        _airConditionRepository = airConditionRepository,
        super(const AirConditionState()) {
    on<AirConditionDataRequested>(_onDataRequested);
    on<AirConditionTemperatureChanged>(_onTemperatureChanged);
    on<AirConditionWindSpeedChanged>(_onWindSpeedChanged);
    on<AirConditionPowerChanged>(_onPowerChanged);
  }

  final IMqttService _mqttService;
  final IAirConditionRepository _airConditionRepository;

  void _onDataRequested(
    AirConditionDataRequested event,
    Emitter<AirConditionState> emit,
  ) async {
    await _airConditionRepository.subscribeToAirConditionData();
    await emit.forEach(
      _mqttService.dataReceived,
      onData: (data) {
        final airConditionData =
            _airConditionRepository.getAirConditionData(data);
        return state.copyWith(
          temperature: airConditionData.temperature,
          windSpeed: airConditionData.windSpeed,
          isAcOn: airConditionData.isAcOn,
        );
      },
    );
  }

  void _onTemperatureChanged(
    AirConditionTemperatureChanged event,
    Emitter<AirConditionState> emit,
  ) {
    final airConditionData = AirConditionModel(
        temperature: event.temperature,
        windSpeed: state.windSpeed,
        isAcOn: state.isAcOn);
    _airConditionRepository.publishTemperature(airConditionData);
  }

  void _onWindSpeedChanged(
    AirConditionWindSpeedChanged event,
    Emitter<AirConditionState> emit,
  ) {
    final airConditionData = AirConditionModel(
      temperature: state.temperature,
      windSpeed: event.windSpeed,
      isAcOn: state.isAcOn,
    );
    _airConditionRepository.publishTemperature(airConditionData);
  }

  void _onPowerChanged(
    AirConditionPowerChanged event,
    Emitter<AirConditionState> emit,
  ) {
    final airConditionData = AirConditionModel(
      temperature: state.temperature,
      windSpeed: state.windSpeed,
      isAcOn: event.isAcOn,
    );
    _airConditionRepository.publishTemperature(airConditionData);
  }
}
