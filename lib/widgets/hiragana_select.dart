import 'package:flutter/material.dart';

class HiraganaSelectionItem extends StatelessWidget {
  final String value;

  const HiraganaSelectionItem({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 35),
        ),
      ),
    );
  }
}
