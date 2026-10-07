import 'package:flutter/material.dart';

class StatusItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const StatusItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          Row(
            children: [
              Icon(Icons.circle, color: color, size: 9),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
