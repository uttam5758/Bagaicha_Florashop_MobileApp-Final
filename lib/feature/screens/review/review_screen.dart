import 'package:cybershop/models/review.dart';
import 'package:cybershop/feature/screens/review/review_UI.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    final productData = ModalRoute.of(context)!.settings.arguments as Map;
    List<Review> reviews = productData['reviews'];
    print(reviews.length);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ReviewUI(
            // image: 'assets/image/avtar.jpg',
            name: reviews[index].name,
            date: reviews[index].time,
            comment: reviews[index].comment,
            ratings: 3,
            onTap: () => setState(() {
              isMore = !isMore;
            }),
            isLess: !isMore,
            onPressed: () {
              setState(() {
                isMore = !isMore;
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 5,
          );
        },
        itemCount: reviews.length,
      ),
    );
  }
}
