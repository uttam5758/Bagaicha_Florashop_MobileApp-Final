import 'package:cybershop/api/productAPI.dart';
import 'package:cybershop/response/productResponse.dart';

class ProductRepository {
  Future<ProductResponse?> getproducts(String? search) async {
    return ProductAPI().getproduct(search);
  }
}
