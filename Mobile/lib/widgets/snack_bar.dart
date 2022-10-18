import 'package:flutter/material.dart';
import 'package:relax/my_theme.dart';

class Snackbar {
  void showSnack(String message, Function? undo) =>
        SnackBar(
          content: Text(message),
          action: undo != null
              ? SnackBarAction(
                  textColor:
                      MyTheme.dark_grey,
                  label: "Undo",
                  onPressed: () => undo,
                )
              : null,
        );
}
