part of 'air_condition_bloc.dart';

class AirConditionState extends Equatable {
  const AirConditionState({
    this.windSpeed = '0',
    this.temperature = '24',
    this.isAcOn = false,
  });

  final String windSpeed;
  final String temperature;
  final bool isAcOn;

  @override
  List<Object> get props => [windSpeed, temperature, isAcOn];

  AirConditionState copyWith({
    String? windSpeed,
    String? temperature,
    bool? isAcOn,
  }) {
    return AirConditionState(
      windSpeed: windSpeed ?? this.windSpeed,
      temperature: temperature ?? this.temperature,
      isAcOn: isAcOn ?? this.isAcOn,
    );
  }
}
