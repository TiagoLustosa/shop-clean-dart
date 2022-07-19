import 'dart:math';
import 'package:flutter/material.dart';
import '../components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(98, 15, 125, 158),
                  Color.fromARGB(255, 10, 3, 71),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 70,
                  ),
                  transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.white70,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Minha Loja',
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Anton',
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                  ),
                ),
                const AuthForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
