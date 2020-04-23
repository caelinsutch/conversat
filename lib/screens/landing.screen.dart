import 'package:Conversat/components/buttons.dart';
import 'package:Conversat/services/auth.dart';
import 'package:Conversat/shared/actions.dart';
import 'package:Conversat/styles/styles.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 247, 247),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              height: 125,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "CONVERSAT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: "Visby Round CF",
                      fontWeight: FontWeight.w700,
                      fontSize: 44,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 26, bottom: 3),
                    child: Text(
                      "ASK QUESTIONS.\nGET ANSWERS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: "Visby Round CF",
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 326,
              height: 60,
              margin: EdgeInsets.only(bottom: 25),
              child: PurpleButton(
                    onPressed: () async => this.onPressed(context),
                child: Text(
                  "Login with Google",
                  textAlign: TextAlign.center,
                  style: TextStyles.h2White,
                ),
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(bottom: 30),
              child: Text(
                "By signing up you agree to the terms of service and privacy policy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey4,
                  fontFamily: "Visby Round CF",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed(context) async {
    bool authRes = await auth.googleSignIn();
    if (authRes == null) {
      FlutterActions.purpleSnackBarTop(context, 'Error logging in!');
    } else if (authRes == false) {
      Navigator.popAndPushNamed(context, '/finish-signup');
    } else if (authRes == true) {
      Navigator.popAndPushNamed(context, '/home');
    }
  }
}
