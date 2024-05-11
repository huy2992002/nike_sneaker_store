import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';

class NSSwitch extends StatelessWidget {
  const NSSwitch({
    required this.onChanged,
    this.isDark = false,
    super.key,
  });

  final Function() onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        height: 30,
        width: 46,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inverseSurface,
          border: Border.all(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: isDark ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDark ? Icons.nightlight_round_sharp : Icons.wb_sunny_rounded,
                color: NSColor.secondaryContainer,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
