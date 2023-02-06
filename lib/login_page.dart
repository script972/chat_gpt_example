import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login page"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Custom Logo
              Center(
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 250,
                ),
              ),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _emailController.text = value;
                },
                validator: (value) {
                  return !value.contains('@') ? "Please enter a valid email." : null;
                },
              ),

              // Password field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _passwordController.text = value;
                },
                validator: (value) {
                  return value.length < 6 ? "Password must be longer than 6 characters." : null;
                },
              ),

              // Login button
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return RaisedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      _formKey.currentState.save();
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      )
                          .then((user) {
                        Navigator.pushReplacementNamed(context, '/home');
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
