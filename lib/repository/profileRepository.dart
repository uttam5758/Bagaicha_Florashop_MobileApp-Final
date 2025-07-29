
import 'package:cybershop/api/profileAPI.dart';
import 'package:cybershop/response/profileResponse.dart';

class ProfileRepository {
  Future<ProfileResponse?> getprofile() async {
    return ProfileAPI().getprofile();
  }
}

