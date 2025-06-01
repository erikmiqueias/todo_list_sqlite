import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TodoTitle extends StatelessWidget {
  const TodoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                Theme.of(
                  context,
                ).colorScheme.copyWith(surface: Colors.white).surface,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 30,
          height: 30,
          child: SvgPicture.asset('assets/switch_icon.svg'),
        ),
        Text(
          'Lista de Tarefas',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
