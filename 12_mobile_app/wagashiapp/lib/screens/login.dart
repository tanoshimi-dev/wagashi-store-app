import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/services/auth_service.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _login() async {
      // final email = _emailController.text;
      // final password = _passwordController.text;
      print('login button pressed　👆');

      final email = "joy03@example.com";
      final password = "password";

      //final success = await _authService.login(email, password);
      final success = await _authService.hello();

      if (success) {
        // Navigator.pushReplacementNamed(context, '/home');
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      }
    }

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: 'Username',
              //   ),
              // ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: 'Password',
              //   ),
              //   obscureText: true,
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              // ElevatedButton(
              //     onPressed: () {
              //       // context.pushReplacement('/catalog');
              //       context.pushReplacement('/home');
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.amber,
              //     ),
              //     child: const Text('ENTER',
              //         style: TextStyle(
              //             color: Colors.white) // Change the color here
              //         )),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
