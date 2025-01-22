import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:api_integration/API/rest_API/user_model_new.dart';

class ApiConstants {
  static String baseUrl = "https://jsonplaceholder.typicode";
  static String userEndPoint = '/users';
}

class ApiService {
  Future<List<UserModel>?> getUsers() async {
    try{
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndPoint);
      var response = await http.get(url);
      if (response.statusCode==200){
        List<UserModel> model = userModelFromJson(response.body);
        return model;
      }

    }catch(e){
      log(e.toString());
    }
    return null;
  }
}
