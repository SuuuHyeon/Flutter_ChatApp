import 'package:firebase_practice/helper/helper_function.dart';
import 'package:firebase_practice/pages/auth/login_page.dart';
import 'package:firebase_practice/pages/home_page.dart';
import 'package:firebase_practice/service/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";

  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Groupie',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text('Groupie를 이용하기 전에 계정을 생성해주세요!',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                      Image.asset('assets/register.png'),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "이름",
                          prefixIcon: Icon(Icons.person,
                              color: Theme.of(context).primaryColor),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "이름을 필수입력 사항입니다.";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "E-mail",
                          prefixIcon: Icon(Icons.email,
                              color: Theme.of(context).primaryColor),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },

                        //유효성 검사
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "유효한 이메일을 입력해주세요.";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "비밀번호",
                          prefixIcon: Icon(Icons.email,
                              color: Theme.of(context).primaryColor),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value!.length < 6) {
                            return "패스워드는 6자 이상이어야 합니다.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            '가입완료',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                        text: "이미 계정이 있으신가요?",
                        children: <TextSpan>[
                          TextSpan(
                              text: " 로그인 하기",
                              style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const LoginPage());
                                }),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          //shared preference 저장
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmail(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
