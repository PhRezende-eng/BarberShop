import 'package:barber_shop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class BarberShopScheduleCard extends StatelessWidget {
  final String schedule;
  final bool selected;
  final VoidCallback onTap;
  const BarberShopScheduleCard({
    required this.schedule,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: !selected ? ColorsConstants.brown : Colors.white),
          color: selected ? ColorsConstants.brown : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Text(
          schedule,
          style: TextStyle(
              color: !selected ? ColorsConstants.brown : Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
