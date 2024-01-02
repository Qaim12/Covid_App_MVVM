
import 'package:flutter/cupertino.dart';
import 'package:simple_api_testing/model/corona_countries_model.dart';
import '../data/responce/api_responce.dart';
import '../model/corona_model.dart';
import '../repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myrepo = HomeRepository();
  ApiResponse<List<CoronaDetailsModel>> coronaList = ApiResponse.loading();
  setCoronaList(ApiResponse<List<CoronaDetailsModel>> response){
    coronaList = response;
    notifyListeners();
  }

  Future<void> fetchCoronaListApi() async{
    setCoronaList(ApiResponse.loading());
    _myrepo.fetchCoronaListApi().then((value){
      setCoronaList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      setCoronaList(ApiResponse.error(error.toString()));
    });
  }
  ApiResponse<List<CoronaCountriesModel>> coronaCountryList = ApiResponse.loading();
  setCoronaCountryList(ApiResponse<List<CoronaCountriesModel>> response){
    coronaCountryList = response;
    notifyListeners();
  }

  Future<void> fetchCountriesListApi() async{
    setCoronaCountryList(ApiResponse.loading());
    _myrepo.fetchCountriesListApi().then((value){
      setCoronaCountryList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      setCoronaCountryList(ApiResponse.error(error.toString()));
    });
  }

}
