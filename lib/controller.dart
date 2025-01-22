import 'package:get/get.dart';
import 'package:api_integration/controller.dart';
import 'package:api_integration/listing_Controller.dart';
import 'package:api_integration/network_Service.dart';
import 'package:api_integration/user_model.dart';
class UserListController extends GetxController
    with StateMixin<List<UserModel>> {
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  fetchUsers() async {
    change([], status: RxStatus.loading());
    try {
      var res = await UserNetworkService().getListOfUsers();
      if (res.results!.isNotEmpty) {
        change(res.results!, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    } on Exception catch (err) {
      change([], status: RxStatus.error(err.toString()));
    }
  }
}