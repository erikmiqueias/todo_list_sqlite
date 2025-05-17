import 'package:flutter/material.dart';

class ModalButton extends StatelessWidget {
  const ModalButton({super.key, required this.onPress, required this.child});

  final Widget child;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor:
            Theme.of(context).colorScheme
                .copyWith(surface: const Color.fromARGB(255, 47, 60, 136))
                .surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: child,
    );
  }
}
