import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/repository/productRepository.dart';
import 'package:cybershop/repository/reviewReposiory.dart';
import 'package:cybershop/repository/userRepository.dart';
import 'package:cybershop/response/productResponse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserRepository? userRepository;
  group("test user register and login", () {
    setUp(() {
      userRepository = UserRepository();
    });
    test("user login test", () async {
      bool expectedResult = true;
      String email = "rohan@gmail.com";
      String password = "12345678";
      User user = User(email: email, password: password);
      bool actual = await UserRepository().loginUser(user);
      expect(actual, expectedResult);
    });

    test("get all product", () async {
      bool expectedResult = true;

      ProductResponse? actial = await ProductRepository().getproducts("havit");
      expect(actial!.success, expectedResult);
    });

    test("user change password", () async {
      bool expectedResult = true;

      String oldPassword = "12345678";

      String newPassword = "123456789";

      String passwordConfirm = "123456789";

      bool actual = await UserRepository()
          .changePassword(oldPassword, newPassword, passwordConfirm);

      expect(actual, expectedResult);
    });

    test("user register test", () async {
      bool expectedResult = true;
      String name = "kripathapaaaa ";
      String email = "kripaathapaaa@gmail.com";
      String password = "kripa12345676";
      User user = User(name: name, email: email, password: password);
      bool actual = await UserRepository().registerUser(user);
      expect(actual, expectedResult);
    });

    test("user product test", () async {
      bool expectedResult = true;

      String productId = "63e8fd4ac44a30a63cd0b89b";

      String comment = "hari@gmail.com";

      int rating = 2;

      bool actial =
          await ReviewRepository().addReview(productId, rating, comment);

      expect(actial, expectedResult);
    });
  });
}
