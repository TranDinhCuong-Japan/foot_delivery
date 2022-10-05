import 'package:flutter/cupertino.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(icon, color: iconColor,),
          SizedBox(width: Dimensison.size5),
          SmallText(text: text,)
        ],
      ),
    );
  }
}
