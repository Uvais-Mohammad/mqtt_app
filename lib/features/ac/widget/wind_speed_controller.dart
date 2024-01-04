import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/features/ac/logic/air_condition/air_condition_bloc.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

class WindSpeedController extends StatelessWidget {
  const WindSpeedController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Speed',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            BlocBuilder<AirConditionBloc, AirConditionState>(
              builder: (context, state) {
                return StepperSwipe(
                  initialValue: 1,
                  onChanged: (int value) {
                    context
                        .read<AirConditionBloc>()
                        .add(AirConditionWindSpeedChanged(value.toString()));
                  },
                  firstIncrementDuration: const Duration(milliseconds: 250),
                  secondIncrementDuration: const Duration(milliseconds: 100),
                  direction: Axis.horizontal,
                  maxValue: 10,
                  minValue: 1,
                  stepperValue: int.parse(state.windSpeed),
                  iconsColor: Colors.black,
                  withFastCount: true,
                  withPlusMinus: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}