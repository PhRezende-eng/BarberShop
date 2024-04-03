import 'package:barber_shop/src/core/ui/widgets/schedule_card.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatefulWidget {
  final Map<String, String?> selectedDays;
  const WeekdaysPanel({required this.selectedDays, super.key});

  @override
  State<WeekdaysPanel> createState() => _WeekdaysPanelState();
}

class _WeekdaysPanelState extends State<WeekdaysPanel> {
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
                      onTap: () {
                        if (widget.selectedDays[day] == null) {
                          widget.selectedDays[day] = day;
                        } else {
                          widget.selectedDays[day] = null;
                        }
                      },
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
