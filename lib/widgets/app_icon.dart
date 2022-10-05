import 'package:flutter/cupertino.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgoundColor;
  final Color iconColor;
  final double iconSize;
  final double size;
  const AppIcon({Key? key,
    required this.icon,
    this.backgoundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.iconSize=20.0,
    this.size=40.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size==40?Dimensison.size40:size,
      height: size==40?Dimensison.size40:size,
      decoration: BoxDecoration(
        color: backgoundColor,
        borderRadius: BorderRadius.circular(size/2)
      ),
      child: Icon(icon, color: iconColor, size: iconSize,),
    );
  }
}
