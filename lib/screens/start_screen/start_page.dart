import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:hangeureut/providers/auth/auth_provider.dart';
import 'package:hangeureut/providers/profile/profile_state.dart';
import 'package:hangeureut/providers/signup/signup_state.dart';
import 'package:hangeureut/repositories/auth_repository.dart';
import 'package:hangeureut/screens/basic_screen/basic_screen_page.dart';
import 'package:hangeureut/screens/splash_screen/splash_page.dart';
import 'package:hangeureut/screens/start_screen/start_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/custom_error.dart';
import '../../models/user_model.dart';
import '../../providers/signup/signup_provider.dart';
import '../../widgets/error_dialog.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);
  static const String routeName = '/start';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool _top = false;
  bool progress = false;
  bool _visible = false;
  bool _detail = false;
  bool _kakao = false;
  bool _loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fbAuth.User? user = fbAuth.FirebaseAuth.instance.currentUser;
    if (user == null) {
    } else {
      _loggedIn = false;
    }

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _top = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _visible = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (_loggedIn) {
        Navigator.pushNamed(context, SplashPage.routeName);
      }
    });

    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        _detail = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1300), () {
      setState(() {
        _kakao = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authState = context.watch<AuthState>();
    // if (authState.authStatus == AuthStatus.authenticated) {
    //   Future.delayed(const Duration(milliseconds: 1500), () {
    //     //TODO: ????????? ?????? ?????????????????? ??? ?????????
    //     Navigator.popAndPushNamed(context, SplashPage.routeName);
    //   });
    // }

    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            width: double.infinity,
            height: double.infinity,
            color: _visible ? kBasicColor : Colors.white,
            duration: Duration(milliseconds: 1000),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2.3,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 800),
              opacity: _top ? 0 : 1,
              child: Column(children: [
                Image.asset(
                  "images/main_icon.png",
                  width: 118,
                ),
              ]),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2.4,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        child: SizedBox(
                          height: _detail ? 40 : 10,
                          child: _detail
                              ? AnimatedAlign(
                                  duration: Duration(milliseconds: 1500),
                                  alignment: _detail
                                      ? Alignment.bottomCenter
                                      : Alignment.topCenter,
                                  child: Text(
                                    "?????? ????????? ??????",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "Cafe24"),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Center(
                        child: AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            "?????????",
                            style: kTitleStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80.0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _kakao && !_loggedIn ? 1 : 0,
              duration: Duration(milliseconds: 500),
              child: Center(child: LoginButtons()),
            ),
          )
        ],
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  LoginButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignupStatus status = context.watch<SignupState>().signupStatus;
    if (status == SignupStatus.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SplashPage.routeName);
      });
    }
    return status == SignupStatus.submitting
        ? CircularProgressIndicator(
            color: Colors.white,
          )
        : Column(
            children: [
              Container(
                width: 170.0,
                child: GestureDetector(
                    child: Image.asset('images/kakao_login_large_narrow.png'),
                    onTap: () async {
                      try {
                        await context.read<SignupProvider>().signup();
                      } on CustomError catch (e) {
                        errorDialog(context, e);
                        return;
                      }
                    }),
              ),
              SizedBox(
                height: 7.2,
              ),
              SizedBox(
                width: 170,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await context.read<SignupProvider>().appleSignUp();
                    } on CustomError catch (e) {
                      errorDialog(context, e);
                      return;
                    }
                  },
                  child: Image.asset('images/apple_login.png'),
                ),
              ),
            ],
          );
  }
}
