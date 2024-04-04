import 'package:barber_shop/src/core/ui/widgets/schedule_card.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  final void Function(String) onChangeValue;
  const WeekdaysPanel({required this.onChangeValue, super.key});

  @override
  Widget build(BuildContext context) {
    const days = [
      "Seg",
      "Ter",
      "Qua",
      "Qui",
      "Sex",
      "Sáb",
      "Dom",
    ];

    return Column(
      children: [
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Selecione os dias da semana',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days
                .map(
                  (day) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarbershopScheduleButton(
                      label: day,
                      onChangeValue: onChangeValue,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
