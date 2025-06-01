import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_sqlite/screens/tabs.dart';
import 'package:todo_list_sqlite/widgets/login_button.dart';
import 'package:todo_list_sqlite/widgets/todo_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _goToMainScreen(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const TodoTitle()],
                ),
                const SizedBox(height: 50),
                SvgPicture.asset(
                  'assets/login_page_vector.svg',
                  width: 350,
                  height: 350,
                ),
                const SizedBox(height: 20),
                Text(
                  'Organize sua vida com facilidade.',
                  style: TextStyle(
                    color:
                        Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: Colors.white)
                            .color,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                LoginButton(
                  onChangeScreen: () {
                    _goToMainScreen(context);
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Continue com mais opções',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Por continuar, você concorda com nossos Termos de Uso e Política de Privacidade.',
                  style: TextStyle(color: Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
