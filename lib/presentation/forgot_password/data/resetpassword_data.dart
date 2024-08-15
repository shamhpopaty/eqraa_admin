import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);

  postdata(
    String code,
    String password,
      String passwordConfirmation,
  ) async {
    var response = await crud.postData(AppLink.resetPassword, {
      "code": code,
      "password": password,
      "password_confirmation":passwordConfirmation,
    });
    return response.fold((l) => l, (r) => r);
  }
}
