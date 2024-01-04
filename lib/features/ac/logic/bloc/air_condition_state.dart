part of 'air_condition_bloc.dart';

class AirConditionState extends Equatable {
  const AirConditionState({
    this.windSpeed = '0',
    this.temperature = '0',
    this.humidity = '0',
  });

  final String windSpeed;
  final String temperature;
  final String humidity;

  @override
  List<Object> get props => [windSpeed, temperature, humidity];

  AirConditionState copyWith({
    String? windSpeed,
    String? temperature,
    String? humidity,
  }) {
    return AirConditionState(
      windSpeed: windSpeed ?? this.windSpeed,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }
}
