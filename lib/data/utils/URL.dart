import 'package:task_manager/UI/Screen/EmailVerify_Screen.dart';
import 'package:task_manager/UI/Screen/OTPverify_Screen.dart';

class URLs {
  static String? Email;
  static String? OTP;
  static String baseURL = 'https://task.teamrabbil.com/api/v1';
  static String signupURL = '$baseURL/registration';
  static String loginURL = '$baseURL/login';
  static String createTaskURL = '$baseURL/createTask';
  static String taskStatusCountURL = '$baseURL/taskStatusCount';

  static String NewTaskListURL(String status) =>
      '$baseURL/listTaskByStatus/$status';

  static String DeleteTaskURL(String id) => '$baseURL/deleteTask/$id';
  static String ChangeStatusTaskURL(String id,String status) => '$baseURL/updateTaskStatus/$id/$status';
  static String UpdateProfileURL = '$baseURL/profileUpdate';

  static EmailverifyURL(String email) {
    Email = email;
    return '$baseURL/RecoverVerifyEmail/$email';
  }
  static OTPverifyURL(String Otp) {
    OTP=Otp;
   return '$baseURL/RecoverVerifyOTP/$Email/$Otp';
  }
  static String SetPassURL = '$baseURL/RecoverResetPass';
}
