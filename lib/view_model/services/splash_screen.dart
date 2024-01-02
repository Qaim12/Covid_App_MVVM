
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../model/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();
  void cheakAuthentication(BuildContext context)async{
    getUserData().then((value) async {
      if(value.token == 'null' || value.token.toString() == ''){
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}