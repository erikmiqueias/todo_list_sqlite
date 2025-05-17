import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onChangeScreen});

  final void Function() onChangeScreen;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onChangeScreen,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(350, 45),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 2, // agora funciona
      ),
      label: Text(
        'Enter',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          fontSize: 17,
        ),
      ),
      icon: Icon(Icons.login_outlined, size: 25),
    );
  }
}
