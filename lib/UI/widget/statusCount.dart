import 'package:flutter/material.dart';

class StatusCount extends StatelessWidget {
  const StatusCount({
    super.key,
    required,
    required this.title,
    required this.count,
  });

  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 3,
      child: SizedBox(
        height: 90,
        width: 90,
        child: Column(
          children: [
            const SizedBox(height: 0),
            Text(
              count,
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(title, style: textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
