import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/features/ac/logic/air_condition/air_condition_bloc.dart';
import 'package:mqtt_app/features/ac/widget/ac_app_bar.dart';
import 'package:mqtt_app/features/ac/widget/data_card.dart';
import 'package:mqtt_app/features/ac/widget/power_button.dart';
import 'package:mqtt_app/features/ac/widget/temperature_slider.dart';
import 'package:mqtt_app/features/ac/widget/wind_speed_controller.dart';

class AirConditionScreen extends StatefulWidget {
  const AirConditionScreen({Key? key}) : super(key: key);
  @override
  State<AirConditionScreen> createState() => _AirConditionScreenState();
}

class _AirConditionScreenState extends State<AirConditionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AirConditionBloc>().add(const AirConditionDataRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AcAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: BlocSelector<AirConditionBloc, AirConditionState,
                        String>(
                      selector: (state) => state.windSpeed,
                      builder: (context, state) {
                        return DataCard(
                          title: 'Wind Speed',
                          value: state,
                          unit: 'm/s',
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocSelector<AirConditionBloc, AirConditionState,
                        String>(
                      selector: (state) => state.temperature,
                      builder: (context, state) {
                        return DataCard(
                          title: 'Temperature',
                          value: state,
                          unit: '°C',
                        );
                      },
                    ),
                  ),
                ],
              ),
              const TemperatureSlider(),
              const Row(
                children: [
                  PowerButton(),
                  WindSpeedController(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


