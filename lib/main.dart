import 'package:Conversat/screens/home.screen.dart';
import 'package:Conversat/screens/landing.screen.dart';
import 'package:Conversat/screens/signup.screen.dart';
import 'package:Conversat/services/services.dart';
import 'package:Conversat/shared/globals.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
        StreamProvider<User>.value(value: Global.userRef.userDataStream()),
        StreamProvider<UserPublic>.value(value: Global.userRef.userPublicDataStream())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: NoOverScroll(),
            child: child,
          );
        },
        theme: ThemeData(
          fontFamily: 'VisbyRoundedCF',
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],
        routes: {
          '/': (context) => LandingScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}

class NoOverScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}