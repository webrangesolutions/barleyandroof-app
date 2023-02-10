import 'package:barleryroof/Utils/routes_names.dart';
import 'package:barleryroof/Views/EmailConfirmPage.dart';
import 'package:barleryroof/Views/ForgotPassPage.dart';
import 'package:barleryroof/Views/LoginPage.dart';
import 'package:barleryroof/Views/SignupPage.dart';
import 'package:barleryroof/Views/Splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RouteName.Splash:
        return MaterialPageRoute(builder: (context) => Splash());

      case RouteName.SignIn:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case RouteName.SignUp:
        return MaterialPageRoute(builder: (context) => SignupPage());

      case RouteName.EmailConfirm:
        return MaterialPageRoute(builder: (context) => EmailConfirmPage());

      case RouteName.ForgotPassword:
        return MaterialPageRoute(builder: (context) => ForgotPassword());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Oop !Something went wrong, try again.'),
            ),
          );
        });
    }
  }
}
