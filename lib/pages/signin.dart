import 'package:amz_finance/pages/signup.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:flutter/cupertino.dart';
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email'),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _emailController,
                  validator: (value) =>
                      value!.isEmpty ? 'Email can\'t be empty' : null,
                ),
                SizedBox(height: 20),
                Text('Password'),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _passwordController,
                  validator: (value) =>
                      value!.isEmpty ? 'Password can\'t be empty' : null,
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthService authService = AuthService();
                            authService.signIn(_emailController.text,
                                _passwordController.text);
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.green)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
