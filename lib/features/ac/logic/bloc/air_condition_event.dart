part of 'air_condition_bloc.dart';

sealed class AirConditionEvent extends Equatable {
  const AirConditionEvent();

  @override
  List<Object> get props => [];
}

class AirConditionDataReceived extends AirConditionEvent {
  const AirConditionDataReceived(this.data);

  final String data;

  @override
  List<Object> get props => [data];
}

class AirConditionDataRequested extends AirConditionEvent {
  const AirConditionDataRequested();
}


