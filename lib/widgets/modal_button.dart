import 'package:flutter/material.dart';

class ModalButton extends StatelessWidget {
  const ModalButton({super.key, required this.onPress, required this.child});

  final Widget child;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPress, child: child);
  }
}
