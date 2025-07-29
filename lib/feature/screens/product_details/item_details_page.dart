import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cybershop/models/cart_model.dart';
import 'package:cybershop/repository/reviewReposiory.dart';
import 'package:cybershop/feature/screens/cart/cart_provider.dart';
import 'package:cybershop/feature/screens/cart/helper.dart';
import 'package:cybershop/feature/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cybershop/feature/screens/product_details/constants.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int? rating;
  var comment = '';
  void ShowNot() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'hello wkjshdksdh',
            body: "this is mu notications sdasknd"));
  }

  DBHelper? dbHelper = DBHelper();

  _addReview(bool isReview) {
    if (isReview) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    } else {
      MotionToast.error(description: const Text("Review adding failed"))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final productData = ModalRoute.of(context)!.settings.arguments as Map;
    final id = productData['id'];
    final name = productData['name'];
    final description = productData['description'];
    final price = productData['price'];
    final ratings = productData['ratings'];
    final image = productData['images'];

    final reviews = productData['reviews'];

    print("ccxcxc ${reviews.length}");

    final stock = productData['stock'];
    final time = productData['time'];

    final random = Random();

    int uniqueid = random.nextInt(1600);

    // state management
    RxBool isFavorited = false.obs;

    _postReview() async {
      try {
        ReviewRepository reviewRepository = ReviewRepository();

        bool lstReview = await reviewRepository.addReview(id, rating!, comment);

        if (lstReview) {
          _addReview(true);
        } else {
          _addReview(false);
        }
      } catch (e) {
        MotionToast.error(
          description: Text("Error: ${e.toString()}"),
        ).show(context);
      }
    }

    //dialogue box
    void submitReview() {
      showDialog(
          context: context,
          builder: (context) {
            return RatingDialog(
              initialRating: 1.0,
              // your app's name?
              title: const Text(
                'Submit Review',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // encourage your user to leave a high rating?
              message: const Text(
                'Tap a star to set your rating. Add comment if you will to.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              // your app's logo?
              image: Image.asset(
                "assets/image/rating.jpg",
                height: 120,
              ),
              submitButtonText: 'Submit',
              commentHint: 'Comment here',
              onCancelled: () => print('cancelled'),
              onSubmitted: (response) async {
                setState(() {
                  rating = response.rating.toInt();
                  comment = response.comment;
                });
                _postReview();
              },
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Obx(
              () => isFavorited.value
                  ? const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
            ),
            onPressed: () {
              isFavorited.value = !isFavorited.value;
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 350,
                alignment: Alignment.center,
                child: Image.network(image.toString()),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  color: Color(0xffF3F3F3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 25),
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Text(
                            name.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Positioned(
                            right: 1,
                            bottom: 1,
                            top: 1,
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 0),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  bottomLeft: Radius.circular(35),
                                ),
                                color: Constants.PRIMARY_COLOR,
                              ),
                              child: Text(
                                price.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 25),
                      child: Text(
                        "About",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 25, right: 20),
                      child: Text(
                        description.toString(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.grey),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: const Icon(
                                            Icons.minimize_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Constants.PRIMARY_COLOR,
                                        ),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              height: 37,
                              child: GestureDetector(
                                onTap: () {
                                  dbHelper!
                                      .insert(Cart(
                                          id: uniqueid,
                                          productId: id.toString(),
                                          productName: name.toString(),
                                          initialPrice: price,
                                          productPrice: price,
                                          quantity: 1,
                                          unitTag: name.toString(),
                                          image: image.toString()))
                                      .then((value) {
                                    cart.addTotalPrice(
                                        double.parse(price.toString()));
                                    cart.addCounter();

                                    const snackBar = SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('Product is added to cart'),
                                      duration: Duration(seconds: 1),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }).onError((error, stackTrace) {
                                    print("error$error");
                                    const snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            'Product is already added in cart'),
                                        duration: Duration(seconds: 1));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                                child: Container(
                                  width: 125,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Constants.PRIMARY_COLOR),
                                  child: const Text(
                                    "Cart",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            submitReview();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 157, 74),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 11.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          child: const Text(
                            "Submit review",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/review',
                                arguments: {"reviews": reviews});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 157, 74),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 11.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          child: const Text(
                            "Show review",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
