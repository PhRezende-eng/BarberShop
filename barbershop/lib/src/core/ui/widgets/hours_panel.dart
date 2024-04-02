import 'package:barber_shop/src/core/ui/widgets/schedule_card.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatefulWidget {
  final Map<String, String?> selectedHours;
  const HoursPanel({required this.selectedHours, super.key});

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  @override
  Widget build(BuildContext context) {
    const hours = [
      "08:00",
      "09:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
      "21:00",
      "22:00",
    ];

    return Column(children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Selecione os horários de atendimento',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(height: 8),
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: hours.length ~/ 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          final hour = hours[index];
          return BarbershopScheduleButton(
            onTap: () {
              if (widget.selectedHours[hour] == null) {
                widget.selectedHours[hour] = hour;
              } else {
                widget.selectedHours[hour] = null;
              }
              setState(() {});
            },
            schedule: hour,
            selected: widget.selectedHours[hour] == hour,
          );
        },
        itemCount: hours.length,
      ),
    ]);
  }
}
