import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybershop/api/orderAPI.dart';
import 'package:cybershop/models/cart_model.dart';
import 'package:cybershop/feature/screens/cart/cart_provider.dart';
import 'package:cybershop/feature/screens/cart/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  Map<String, dynamic>? paymentIntentData;
  double? getTotalAmount;

  DBHelper? dbHelper = DBHelper();

  void getTotal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      getTotalAmount = preferences.get('total_price') as double?;

      print(getTotalAmount);
    });
  }

  String? productName;
  String? productImage;
  var address;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    address = arguments['address'];
    var phone = arguments['phone'];
    var country = arguments['country'];

    final cart = Provider.of<CartProvider>(context);
    getTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
        elevation: 4.0,
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipping Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address: ${address}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Phone Number: ${phone}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Country: ${country}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Cart Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 5),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: cart.getData(),
                                builder: (context,
                                    AsyncSnapshot<List<Cart>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isEmpty) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/image/cart.png'),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text('Your cart is empty 😌',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                'Explore products and shop your\nfavourite items',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2)
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              productName = snapshot
                                                  .data![index].productName
                                                  .toString();

                                              productImage = snapshot
                                                  .data![index].image
                                                  .toString();

                                              return Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl: snapshot
                                                                .data![index]
                                                                .image
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            height: 130,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .productName
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    // InkWell(
                                                                    //     onTap:
                                                                    //         () {
                                                                    //       dbHelper!.delete(snapshot
                                                                    //           .data![index]
                                                                    //           .id!);
                                                                    //       cart.removerCounter();
                                                                    //       cart.removeTotalPrice(double.parse(snapshot
                                                                    //           .data![index]
                                                                    //           .productPrice
                                                                    //           .toString()));
                                                                    //     },
                                                                    //     child:
                                                                    //     Icon(
                                                                    //         Icons.delete)
                                                                    //         )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  snapshot
                                                                          .data![
                                                                              index]
                                                                          .unitTag
                                                                          .toString() +
                                                                      " " +
                                                                      r"$" +
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .productPrice
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          35,
                                                                      width:
                                                                          100,
                                                                      decoration: BoxDecoration(
                                                                          // color: const Color.fromARGB(
                                                                          //     255,
                                                                          //     14,
                                                                          //     234,
                                                                          //     117),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  int quantity = snapshot.data![index].quantity!;
                                                                                  int price = snapshot.data![index].initialPrice!;
                                                                                  quantity--;
                                                                                  int? newPrice = price * quantity;

                                                                                  if (quantity > 0) {
                                                                                    dbHelper!.updateQuantity(Cart(id: snapshot.data![index].id!, productId: snapshot.data![index].id!.toString(), productName: snapshot.data![index].productName!, initialPrice: snapshot.data![index].initialPrice!, productPrice: newPrice, quantity: quantity, unitTag: snapshot.data![index].unitTag.toString(), image: snapshot.data![index].image.toString())).then((value) {
                                                                                      newPrice = 0;
                                                                                      quantity = 0;
                                                                                      cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                                    }).onError((error, stackTrace) {
                                                                                      print(error.toString());
                                                                                    });
                                                                                  }
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.remove,
                                                                                  color: Colors.white,
                                                                                )),
                                                                            Text(snapshot.data![index].quantity.toString(),
                                                                                style: TextStyle(color: Colors.white)),
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  int quantity = snapshot.data![index].quantity!;
                                                                                  int price = snapshot.data![index].initialPrice!;
                                                                                  quantity++;
                                                                                  int? newPrice = price * quantity;

                                                                                  dbHelper!.updateQuantity(Cart(id: snapshot.data![index].id!, productId: snapshot.data![index].id!.toString(), productName: snapshot.data![index].productName!, initialPrice: snapshot.data![index].initialPrice!, productPrice: newPrice, quantity: quantity, unitTag: snapshot.data![index].unitTag.toString(), image: snapshot.data![index].image.toString())).then((value) {
                                                                                    newPrice = 0;
                                                                                    quantity = 0;
                                                                                    cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                                  }).onError((error, stackTrace) {
                                                                                    print(error.toString());
                                                                                  });
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.add,
                                                                                  color: Colors.white,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    }
                                  }
                                  return Text('');
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Price Calculation",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const Divider(thickness: 2, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${getTotalAmount}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Delivery Charge",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "\$0",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Subtotal ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${getTotalAmount}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      await makePayment(
                          getTotalAmount!.toStringAsFixed(0).toString());
                    },
                    style: ElevatedButton.styleFrom(
                      // alignment: Alignment.center,
                      // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 13.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String? total) async {
    // paymnet instant method

    try {
      paymentIntentData = await createPaymentIntent(
          total.toString(), 'INR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: stripe.SetupPaymentSheetParameters(
            customerId: paymentIntentData!['customer'] ?? 'Customer',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'ANNIE',
          ))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
              parameters: stripe.PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        OrderAPI().createOrderHistory(
          ProductName: productName,
          ProductImage: productImage,
          ProductPrice: getTotalAmount,
          PaymentType: "Card",
          Address: address,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on stripe.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LLLPoKaRPx08H08Z46lJKUgYNUyVSCdDSRx6HM7gd6E4OKjFXUhTrrvcF40xmkF8twnicdvcS5ajBqaa8NPe7xD00DA6flZc2',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
