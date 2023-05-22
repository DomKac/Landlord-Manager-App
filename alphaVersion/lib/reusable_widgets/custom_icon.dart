import 'package:flutter/material.dart';

import '../constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.iconData,
  });
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: Theme.of(context).iconTheme.color,
      size: 25,
    );
  }
}
