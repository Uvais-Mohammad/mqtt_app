import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_app/features/ac/logic/air_condition/air_condition_bloc.dart';

class PowerButton extends StatelessWidget {
  const PowerButton({
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Power',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5FE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child:
                        BlocSelector<AirConditionBloc, AirConditionState, bool>(
                      selector: (state) => state.isAcOn,
                      builder: (context, state) {
                        return Text(
                          state ? 'ON' : 'OFF',
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'Turn on/off the AC',
                style: TextStyle(
                  color: Color(0xFFA0A3B1),
                  fontSize: 13,
                ),
              ),
              BlocSelector<AirConditionBloc, AirConditionState, bool>(
                selector: (state) => state.isAcOn,
                builder: (context, state) {
                  return Center(
                    child: Switch(
                      value: state,
                      onChanged: (value) {
                        context
                            .read<AirConditionBloc>()
                            .add(AirConditionPowerChanged(value));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}