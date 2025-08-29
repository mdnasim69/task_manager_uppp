class URLs{
  static String baseURL ='https://task.teamrabbil.com/api/v1';
  static String signupURL ='$baseURL/registration';
  static String loginURL ='$baseURL/login';
  static String createTaskURL ='$baseURL/createTask';
  static String taskStatusCountURL ='$baseURL/taskStatusCount';
  static String NewTaskListURL(String status)=>'$baseURL/listTaskByStatus/$status';
  static String DeleteTaskURL(String id)=>'$baseURL/deleteTask/$id';
  static String UpdateProfileURL ='$baseURL/profileUpdate';
}