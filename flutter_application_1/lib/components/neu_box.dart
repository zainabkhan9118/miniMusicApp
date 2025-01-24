import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          //Darker shadow bottom right
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
          ),
          //Lighter shadow top left
          BoxShadow(
            color: Colors.white,
            offset: const Offset(-4, -4),
            blurRadius: 15,
          ),
        ],
      ),
      child: child,  // Add the child property here
    );
  }
}