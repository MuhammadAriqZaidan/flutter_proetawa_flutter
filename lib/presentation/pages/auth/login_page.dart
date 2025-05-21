import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/presentation/auth/blocs/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isClicked = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 80),
          const Center(
            child: Text(
              "ION Presensi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 3),
          const Center(
            child: Text(
              'Presensi APP',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess && !_hasNavigated) {
                _hasNavigated = true; // ✅ Supaya hanya navigasi sekali

                setState(() {
                  isClicked = false;
                });

                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('token', state.loginModel.accessToken);

                Future.microtask(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text("Login Berhasil")),
                      backgroundColor: Colors.green,
                    ),
                  );
                });

                Future.microtask(() {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                });
              }

              if (state is LoginFailure) {
                setState(() {
                  isClicked = false;
                });

                final errorMessage = jsonDecode(state.message)['message'];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text(errorMessage)),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: (state is LoginLoading || isClicked)
                      ? null
                      : () {
                          setState(() {
                            isClicked = true;
                          });

                          context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email: usernameController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: state is LoginLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Login'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
