import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productImagePath;
  final String productName;
  final String productPrice;
  final Function() onPressed;

  const ProductCard(
      {required this.productImagePath,
      required this.productName,
      required this.onPressed,
      required this.productPrice});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: Colors.teal
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: productImagePath,
                  fit: BoxFit.cover,
                  height: 130,
                  width: double.infinity,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // Text(
                    //   'With Almond Milk',
                    //   style: TextStyle(
                    //     color: Colors.grey[700],
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productPrice,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
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
