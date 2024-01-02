import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_api_testing/utils/routes/routes.dart';
import 'package:simple_api_testing/utils/routes/routes_name.dart';
import 'package:simple_api_testing/view_model/auth_view_model.dart';
import 'package:simple_api_testing/view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splashView,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}

