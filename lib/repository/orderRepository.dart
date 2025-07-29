import 'package:cybershop/api/orderAPI.dart';
import 'package:cybershop/response/orderResponse.dart';

class OrderRepository{
  Future<OrderResponse> getOrderHistory() async{
    return OrderAPI().getOrderHistory();
  }
}
