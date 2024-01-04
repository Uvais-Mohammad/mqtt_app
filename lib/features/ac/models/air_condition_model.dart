class AirConditionModel {
  final String windSpeed;
  final String temperature;
  final bool isAcOn;

  AirConditionModel({
    required this.windSpeed,
    required this.temperature,
    this.isAcOn = false,
  });

  factory AirConditionModel.fromJson(Map<String, dynamic> json) {
    return AirConditionModel(
      windSpeed: json['windSpeed'],
      temperature: json['temperature'],
      isAcOn: json['isAcOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'windSpeed': windSpeed,
      'temperature': temperature,
      'isAcOn': isAcOn,
    };
  }

  AirConditionModel copyWith({
    String? windSpeed,
    String? temperature,
    bool? isAcOn,
  }) {
    return AirConditionModel(
      windSpeed: windSpeed ?? this.windSpeed,
      temperature: temperature ?? this.temperature,
      isAcOn: isAcOn ?? this.isAcOn,
    );
  }
}
