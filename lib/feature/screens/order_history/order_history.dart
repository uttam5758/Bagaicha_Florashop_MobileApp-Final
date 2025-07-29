import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybershop/util/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late Future<List<dynamic>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  Future<List<dynamic>> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    print(email);

    final response =
        await http.get(Uri.parse(baseUrl + 'order/flutter/$email'));

    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // generate random number using dart:math library
  int randomNumber = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CachedNetworkImage(
                                imageUrl: product['productImage'],
                                fit: BoxFit.cover,
                                height: 120,
                                width: MediaQuery.of(context).size.width / 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // bold text
                                    Text(
                                      "Order Id: ${product['_id']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      product['productName'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),

                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Price : ${product['productPrice']}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                                'PAID | ${product['paymentType']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Devlivery to : ${product['address']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
