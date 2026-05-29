import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width = 180,
    this.height = 56,
    this.alignment = Alignment.center,
  });

  static const assetPath = 'assets/images/site_logo_dark.png';

  final double width;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
      alignment: alignment,
      semanticLabel: 'WebCal 项目 Logo',
    );
  }
}
