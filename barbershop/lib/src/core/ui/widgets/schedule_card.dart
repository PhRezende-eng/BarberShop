import 'package:barber_shop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class BarbershopScheduleButton extends StatefulWidget {
  final String label;
  final void Function(String) onChangeValue;

  const BarbershopScheduleButton({
    required this.label,
    required this.onChangeValue,
    super.key,
  });

  @override
  State<BarbershopScheduleButton> createState() =>
      _BarbershopScheduleButtonState();
}

class _BarbershopScheduleButtonState extends State<BarbershopScheduleButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChangeValue(widget.label);
        setState(() {
          selected = !selected;
        });
      },
      behavior: HitTestBehavior.opaque,
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
          widget.label,
          style: TextStyle(
              color: !selected ? ColorsConstants.brown : Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
