part of 'air_condition_bloc.dart';

sealed class AirConditionEvent extends Equatable {
  const AirConditionEvent();

  @override
  List<Object> get props => [];
}

class AirConditionDataRequested extends AirConditionEvent {
  const AirConditionDataRequested();
}

class AirConditionTemperatureChanged extends AirConditionEvent {
  const AirConditionTemperatureChanged(this.temperature);

  final String temperature;

  @override
  List<Object> get props => [temperature];
}

class AirConditionWindSpeedChanged extends AirConditionEvent {
  const AirConditionWindSpeedChanged(this.windSpeed);

  final String windSpeed;

  @override
  List<Object> get props => [windSpeed];
}

class AirConditionPowerChanged extends AirConditionEvent {
  const AirConditionPowerChanged(this.isAcOn);

  final bool isAcOn;

  @override
  List<Object> get props => [isAcOn];
}
