class AppLink {
  static const String ip = "192.168.43.202";
  static const String server = "http://$ip:8000/api";

  //============Image=============================
  static const String imageStatic = "";

  //============================================
  static const String test = "$server/test.php";

  //***************Auth****************
  static const String signUp = "$server/users/auth/sign-up";
  static const String verifycode = "$server/users/auth/email-verify";
  static const String signIn = "$server/users/auth/sign-in";
  static const String resend = "$server/users/auth/resend";

  //--------------resetPassword=============
  static const String forgotPassword = "$server/users/auth/forgot-password";

  static const String resetPassword = "$server/users/auth/password-reset";
  static const String verifyCodePassword =
      "$server/users/auth/check-password-reset-code";

  //------home-----
  static const String home = "$server/books/";
  static const String addBook = "$server/books";

  //------profile------
  static const String profile = "$server/";

  //------showbook-----
  static const String showbook = "$server/";

  //-------descriptionbook----
  static const String descriptionbook = "$server/";

  //-----bookscreen-----
  static const String bookscreen = "$server/books?search=category[l]=";
  static const String complaintsScreen = "$server/complaints";

}
