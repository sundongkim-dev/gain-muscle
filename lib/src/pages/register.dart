import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:gain_muscle/src/pages/home.dart';
import 'package:gain_muscle/src/pages/validate.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _success = false;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "  회원가입",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "이메일",
                ),
                focusNode: _emailFocus,
                validator: (value) =>
                    CheckValidate().validateEmail(_emailFocus, value!),
                controller: _emailController,
                onSaved: (value) => _emailController.text = value!.trim(),
              ),
              TextField(
                maxLines: 1,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "닉네임",
                ),
              ),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "비밀번호",
                ),
                validator: (value) => CheckValidate().validatePassword(_passwordFocus, value!),
                controller: _passwordController,
                onSaved: (value) => _passwordController.text = value!.trim(),
              ),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "비밀번호 확인",
                ),
                validator: (value) => CheckValidate().checkPassword(_passwordFocus, value!, _passwordController),
              ),
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  backgroundColor: Colors.redAccent,
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      _register();
                      if(_userEmail != ''){
                        Navigator.of(context).pop();
                      }
                    }
                    print("Wrongapproach");
                  },
                  text: "회원가입",
                  icon: Icons.email,
                  width: double.infinity,
                  height: 50,
                ),
              ),
            ],
          )
      ),
    );
  }
  void _register() async {
    final User? user = (await
    _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
    ).user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email!;
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

