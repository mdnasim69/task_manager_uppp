import 'package:get/get.dart';

import '../../data/model/user_model.dart';
import '../../data/service/NetworkCaller.dart';
import '../../data/utils/URL.dart';
import '../Screen/Home.dart';
import 'auth_controller.dart';

class LogInController extends GetxController {
  bool _Loading = false;

  bool get Loading => _Loading;
  String _errorMessage = "Something went wrong";

  String get errorMessage => _errorMessage;
  bool IsSucess = false;

  Future<bool> onLogin(email, password) async {
    _Loading = true;
    update();
    Map<String, dynamic> PostBody = {"email": email, "password": password};
    NetworkResponse response = await Networkcaller.postReqest(
      URLs.loginURL,
      PostBody,
    );

    if (response.isSuccess) {
      String token = response.ResponseBody!['token'];
      UserModel userData = UserModel.fromJson(response.ResponseBody!['data']);
      await AuthController.saveuserData(token, userData);
      _errorMessage = "";
      IsSucess = true;
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   HomeScreen.name,
      //   (predicate) => false,
      // );

      Get.offAllNamed(HomeScreen.name);

    } else {
      print(response.ResponseBody);
      _errorMessage = response.errorMassage;
    }
    _Loading = false;
    update();
    return IsSucess;
  }
}
