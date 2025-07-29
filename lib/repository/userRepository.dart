import 'package:cybershop/api/userAPI.dart';
import 'package:cybershop/models/userModel.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }
  Future<bool> loginUser(User user) async {
    return await UserAPI().loginUser(user);
  }
  
  Future<bool> changePassword(String? oldPassword, String? newPassword, String? passwordConfirm) async {
    return await UserAPI().changePassword(oldPassword, newPassword, passwordConfirm);
  }
  Future<bool> updateProfile(String? name, String? email,) async {
    return await UserAPI().updateProfile(name,email );
  }
}
