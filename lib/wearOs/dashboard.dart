import 'package:cybershop/models/products.dart';
import 'package:cybershop/repository/productRepository.dart';
import 'package:cybershop/response/productResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wear/wear.dart';

class AllProduct extends StatefulWidget {
  static String routeName = '/get_all_product';
  const AllProduct({Key? key}) : super(key: key);
  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List<Product> lstproducts = [];
  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(
        builder: (context, mode, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 2,
                ),
                Text(
                  "All Product",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.brown[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<ProductResponse?>(
                    future: ProductRepository().getproducts(""),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          lstproducts = snapshot.data!.products!;
                          return ListView.builder(
                            itemCount: lstproducts.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              return Card(
                                elevation: 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 2),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 18,
                                        child: Image.network(
                                          lstproducts[i]
                                              .images![0]
                                              .url
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lstproducts[i].name.toString(),
                                              style: TextStyle(
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              lstproducts[i].price.toString(),
                                              style: TextStyle(
                                                  fontSize: 5,
                                                  color: Colors.brown),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );

                              // ListTile(
                              //   minVerticalPadding: 1,
                              //   leading:
                              //   title:
                              //   subtitle:
                              // );
                            },
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text("dgasg");
                      }
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 10,
                        ),
                      );
                    })
              ]),
            ),
          );
        },
      );
    });
  }
}
