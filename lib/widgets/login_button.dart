import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.pathIcon,
    required this.label,
    required this.onChangeScreen,
  });
  final String pathIcon;
  final String label;
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
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 17,
        ),
      ),
      icon: SvgPicture.asset(pathIcon, height: 25, width: 25),
    );
  }
}
