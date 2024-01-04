import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/features/ac/logic/air_condition/air_condition_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TemperatureSlider extends StatelessWidget {
  const TemperatureSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SleekCircularSlider(
        min: 16,
        max: 30,
        initialValue: 16,
        appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
            trackColor: Colors.grey[300],
            progressBarColors: [
              const Color(0xFF1309FC),
              const Color(0xFF9853D1),
              const Color(0xFFFD8DB0),
              const Color(0xFF9853D1),
            ],
            dotColor: Colors.red,
            hideShadow: true,
          ),
          size: 270,
          infoProperties: InfoProperties(
            mainLabelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        onChangeEnd: (double endValue) {
          context.read<AirConditionBloc>().add(
                AirConditionTemperatureChanged(
                  endValue.toInt().toString(),
                ),
              );
        },
        innerWidget: (percentage) {
          return BlocSelector<AirConditionBloc, AirConditionState, String>(
            selector: (state) => state.temperature,
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$state°C',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      'Slide to set temperature',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA0A3B1),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
