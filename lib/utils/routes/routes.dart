import 'package:flutter/material.dart';
import 'package:simple_api_testing/utils/routes/routes_name.dart';
import '../../view/home_view.dart';
import '../../view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RoutesName.splashView:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

    // case RoutesName.login:
    //   return MaterialPageRoute(builder: (context) => const LoginView());

      // case RoutesName.splashView:
      //   return MaterialPageRoute(builder: (context) => const SplashView());

    // case RoutesName.signUp:
    //   return MaterialPageRoute(builder: (context) => const SignUpView());

      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route define'),
            ),
          );

        });
    }
  }
}