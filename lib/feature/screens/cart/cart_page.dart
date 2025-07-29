// import 'package:flutter/material.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               "Shoping Cart",
//               style: TextStyle(
//                 fontSize: 21,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 18.0),
//             CartItem(),
//             CartItem(),
//             CartItem(),
//             CartItem(),
//             SizedBox(height: 22.0),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "Total",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "\u20b9, 480,00",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 4.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "Delivery Charge",
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   "\u20b9, 480,00",
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "Subtotal",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "\u20b9, 480,00",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 10.0),
//             //  Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/order_history');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color.fromARGB(255, 14, 234, 117),
//                 padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 13.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//               ),
//               child: const Text(
//                 "Checkout",
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CartItem extends StatelessWidget {
//   const CartItem({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: <Widget>[
//           Container(
//             width: 80.0,
//             height: 80.0,
//             decoration: BoxDecoration(
//               color: Colors.green[300],
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Center(
//               child: Container(
//                 width: 60.0,
//                 height: 60.0,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.scaleDown,
//                     image: AssetImage("assets/image/facebook.png"),
//                   ),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 12.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   width: 100.0,
//                   child: Text(
//                     "Predator Laptop",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Row(
//                   children: <Widget>[
//                     Container(
//                       width: 20.0,
//                       height: 20.0,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       child: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 15.0,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         "1",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 20.0,
//                       height: 20.0,
//                       decoration: BoxDecoration(
//                         color: Colors.blue[300],
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       child: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 15.0,
//                       ),
//                     ),
//                     Spacer(),
//                     Text(
//                       "\u20b9 12,000",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
