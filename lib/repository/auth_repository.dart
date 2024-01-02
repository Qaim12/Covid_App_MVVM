import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../resources/app_url.dart';

class AuthRepository{
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data)async{

    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;

    }catch(e){
      throw e;
    }
  }
  Future<dynamic> signUpApi(dynamic data)async{

    try{

      dynamic response = await _apiService.getPostApiResponse(AppUrl.registerEndPoint, data);
      return response;
    }catch(e){
      throw e;
    }
  }
}