import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const ButtonWidget({
    @required this.title,
    @required this.icon,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.green),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            Icon(icon, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
