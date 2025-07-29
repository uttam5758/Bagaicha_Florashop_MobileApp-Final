import 'package:cybershop/models/review.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewUI extends StatelessWidget {
  // final String? image;
  final String? name;
  final String? date;
  final String? comment;
  final double ratings;
  final Function() onTap, onPressed;
  final bool isLess;
  const ReviewUI({
    Key? key,
    // this.image,
    this.name,
    this.date,
    this.comment,
    required this.ratings,
    required this.onTap,
    required this.isLess,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  // height: 45.0,
                  // width: 45.0,
                  // margin: EdgeInsets.only(right: 16.0),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(image!),
                  //     fit: BoxFit.cover,
                  //   ),
                  //   borderRadius: BorderRadius.circular(44.0),
                  // ),
                  ),
              Expanded(
                child: Text(
                  name!,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
          Row(
            children: [
              SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: ratings,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
                spacing: 0.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(date!,
                  style: TextStyle(
                    fontSize: 16.0,
                  )),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: onTap,
            child: isLess
                ? Text(
                    comment!,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 224, 126, 20),
                    ),
                  )
                : Text(
                    comment!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
