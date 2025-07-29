import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cybershop/models/products.dart';
import 'package:cybershop/repository/productRepository.dart';
import 'package:cybershop/response/productResponse.dart';
import 'package:cybershop/feature/screens/category_list.dart';
import 'package:cybershop/feature/screens/product_details/item_details_page.dart';
import 'package:cybershop/core/utils/productcard.dart';
import 'package:cybershop/core/utils/sideNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "https://pageneon.com/cdn/shop/files/Flora-Shop-Neon-Signs-Florist-Led-Light-Goldyellow.png?v=1722309309"
  ];
  final List productType = [
    [
      'Annual',
    ],
    [
      'Perennial',
    ],
    [
      'Shrub',
    ],
    [
      'Tree',
    ],
  ];
  // make String dynamci list of product type

  String? search;

  void CategorySelected(int index) {
    setState(() {
      for (int i = 0; i < productType.length; i++) {
        productType[i][1] = false;
      }
      productType[index][1] = true;
    });
  }

  int activeimage = 0;
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeimage,
        count: images.length,
        effect: const JumpingDotEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Colors.red,
            dotColor: Colors.black12),
      );
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: SizedBox(
          height: 30,
          child: TextField(
            onChanged: (Value) {
              setState(() {
                search = Value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 222, 216, 216),
              prefixIcon:
                  const Icon(Icons.search, color: Colors.black, size: 16),
              hintText: 'Search..',
              hintStyle: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.only(top: 5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(36, 203, 128, 1)),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Color.fromARGB(255, 19, 176, 77)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.bedtime_sharp, color: Colors.black),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),

            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                viewportFraction: 0.98,
                // autoPlay: true,
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: CachedNetworkImage(
                        imageUrl: i,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            CarouselSlider(
              items: [
                Image.network(
                    'https://gardeningheavn.com/wp-content/uploads/2020/01/Air-Purifying-House-Plants-1024x690.png'),
                Image.network(
                    'https://unbeleafable.ph/wp-content/uploads/2022/01/home-and-indoor-plants-2022-01-13-21-33-37-utc-2-1200x900.jpg'),
                Image.network(
                    'https://www.almanac.com/sites/default/files/styles/or/public/image_nodes/bonsai-4634225_1920.jpg?itok=v3bSnsNW'),
                Image.network(
                    'https://cdn.shopify.com/s/files/1/0267/1699/5754/files/home-garden-arrangement-with-copy-space_480x480.jpg?v=1622881576'),
              ],
              options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),

            // category section
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("All Flowers",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000))),
            ),

            FutureBuilder<ProductResponse?>(
              future: ProductRepository().getproducts(search),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    ProductResponse productResponse = snapshot.data!;
                    List<Product> lstproducts = snapshot.data!.products!;
                    print(snapshot.data!.products!);
                    return GridView.builder(
                        shrinkWrap: true,
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lstproducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            productName: lstproducts[index].name.toString(),
                            productPrice: lstproducts[index].price.toString(),
                            productImagePath: lstproducts[index]
                                    .images![0]
                                    .url ??
                                "https://m.media-amazon.com/images/I/31yW0ya1eGL.jpg",
                            onPressed: () {
                              Navigator.pushNamed(context, '/new', arguments: {
                                "images": lstproducts[index].images![0].url,
                                "name": lstproducts[index].name,
                                "price": lstproducts[index].price,
                                "description": lstproducts[index].description,
                                "id": lstproducts[index].id,
                                "rating": lstproducts[index].ratings,
                                "stock": lstproducts[index].stock,
                                "reviews": lstproducts[index].reviews,
                                "time": lstproducts[index].time,
                              });
                            },
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
