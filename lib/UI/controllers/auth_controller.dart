
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/model/user_model.dart';

class AuthController{

  static String? getToken;
  static UserModel? userData;

  static Future<void> saveuserData(String acessToken,UserModel usermodel)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
   await preferences.setString('token',acessToken);
   await preferences.setString('userData', jsonEncode(usermodel.toJSON()));
  }

  static Future<bool> IsLogin()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
   String? token= preferences.getString('token');
   if (token!=null){
     await setUserData();
     return true;
   }else{
     return false;}
  }

  static Future<void> setUserData()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? UserData = await preferences.getString('userData');
    getToken =token;
    userData =UserModel.fromJson(jsonDecode(UserData!));
  }

  static Future<void> clearUserData()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.clear();
  }

}