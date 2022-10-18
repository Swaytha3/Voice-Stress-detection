import 'package:flutter/material.dart';

import 'package:relax/my_theme.dart';

class TableCellSettings extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  TableCellSettings({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title??'Relax', style: TextStyle(color: MyTheme.text)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: MyTheme.text, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
