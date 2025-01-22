import 'package:api_integration/API/dio_config.dart';
import 'package:api_integration/user_model.dart';

class UserNetworkService {
  get logger => null;

  Future<ApiResponse<List<UserModel>>> getListOfUsers() async {
    try {
      var res = await Api().get();
      var apiRes = ApiResponse<List<UserModel>>.fromListJson(
          res.data, (p) => p.map((e) => UserModel.fromJson(e)).toList());
      return apiRes;
    } catch (err) {
      logger.e(err);
      throw Exception(err.toString());
    }
  }
}