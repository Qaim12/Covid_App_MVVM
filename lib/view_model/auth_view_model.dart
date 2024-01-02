import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_api_testing/view_model/user_view_model.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final _myrepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.loginApi(data).then((value){
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
          UserModel(
              token: value['token'].toString()
          )
      );
      if(kDebugMode){
        Utils.flushBarErrorMessage('Login Successfully', context);
        Navigator.pushNamed(context, RoutesName.home);
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }}
    );

  }


  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.signUpApi(data).then((value){
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage('SignUp Successfully', context);
        Navigator.pushNamed(context, RoutesName.home);
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }}
    );

  }

}