import 'package:cybershop/api/httpservices.dart';
import 'package:cybershop/models/profiles.dart';
import 'package:cybershop/response/profileResponse.dart';
import 'package:cybershop/util/url.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAPI {
  Future<ProfileResponse?> getprofile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    Future.delayed(const Duration(seconds: 2), () {});
    ProfileResponse? profileResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + getProfileUrl;
      Response response = await dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer ' + token!,
            },
          ));

      print(response.data['user']);

      if (response.statusCode == 200) {
        print(response.data['user']);

        profileResponse = ProfileResponse.fromJson(response.data);
        print("hchcbhchdbchdbchdbchdbchdbchdcbhdcbdhcbhdcbdhcbdhcbhdcbdhc");
      }
    } catch (e) {
      throw Exception(e);
    }
    return profileResponse;
  }
}
