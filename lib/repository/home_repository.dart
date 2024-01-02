import 'package:simple_api_testing/model/corona_countries_model.dart';

import '../data/network/NetworkApiService.dart';
import '../data/network/baseApiService.dart';
import '../model/corona_model.dart';
import '../resources/app_url.dart';

class HomeRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<List<CoronaDetailsModel>> fetchCoronaListApi() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(AppUrl.coronaUrl);
       //print('API Response: $response'); // Print the JSON response
      if (response is Map<String, dynamic>) {
        response = [response]; // Convert the map to a list with a single element
      }
      List<dynamic> jsonList = response as List<dynamic>;
      List<CoronaDetailsModel> coronaList = jsonList.map((json) => CoronaDetailsModel.fromJson(json)).toList();
      return coronaList;
    } catch (e) {
      print('Error fetching product list: $e'); // Print the error to the console
      throw e;
    }
  }

  Future<List<CoronaCountriesModel>> fetchCountriesListApi() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(AppUrl.countryList);
       print('API Response: $response'); // Print the JSON response
      if (response is Map<String, dynamic>) {
        response = [response]; // Convert the map to a list with a single element
      }
      List<dynamic> jsonList = response as List<dynamic>;
      List<CoronaCountriesModel> coronaCountryList = jsonList.map((json) => CoronaCountriesModel.fromJson(json)).toList();
      return coronaCountryList;
    } catch (e) {
      print('Error fetching product list: $e'); // Print the error to the console
      throw e;
    }
  }
}
