import 'dart:math';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final String productType;
  final bool isSelected;
  final VoidCallback onTap;
  Categories(
      {required this.productType,
      required this.isSelected,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          constraints: const BoxConstraints(minWidth: 20, maxWidth: 120),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 33, 33, 33),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              productType,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.orange : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
