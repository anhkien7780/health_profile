import 'package:flutter/material.dart';

class DestinationItem extends StatelessWidget {
  const DestinationItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final onPrimaryFixed = Theme.of(context).colorScheme.onPrimaryFixed;
    final labelTextStyle = Theme.of(context).textTheme.labelLarge;
    return NavigationDestination(
      icon: _buildNavigationDestinationContent(
        iconColor: onPrimaryFixed,
        labelTextStyle: labelTextStyle?.copyWith(color: onPrimaryFixed),
      ),
      selectedIcon: _buildNavigationDestinationContent(
        iconColor: onPrimary,
        labelTextStyle: labelTextStyle?.copyWith(color: onPrimary),
      ),
      label: "",
    );
  }

  Widget _buildNavigationDestinationContent({
    required Color iconColor,
    required TextStyle? labelTextStyle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor),
        Text(label, style: labelTextStyle),
      ],
    );
  }
}
