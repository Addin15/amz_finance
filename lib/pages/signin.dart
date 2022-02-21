import 'package:amz_finance/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) =>
                    value!.isEmpty ? 'Email can\'t be empty' : null,
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) =>
                    value!.isEmpty ? 'Password can\'t be empty' : null,
                obscureText: true,
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthService authService = AuthService();
                      authService.signIn(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  child: Text('Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}
