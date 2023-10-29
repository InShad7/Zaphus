// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zaphus/controller/provider/contoller.dart';

// import 'product_card.dart';

// class HomeCards extends StatelessWidget {
//   const HomeCards({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ControllerProvider>(context);
//     return Scaffold(
//       body: FutureBuilder(
//         future: provider.getProducts(),
//         builder: (context, snapshot) {
//           // if (snapshot.connectionState == ConnectionState.waiting) {
//           //   return const Center(
//           //     child: CircularProgressIndicator(),
//           //   );
//           // } else if (snapshot.hasError) {
//           //   return const Center(
//           //     child: Text("Error fetching data"),
//           //   );
//           // } else
//           if (snapshot.hasData) {
//             final data = snapshot.data;

//             return ListView.builder(
//               itemCount: data!.length,
//               // shrinkWrap: true,
//               // physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final product = data[index];
//                 // Handle the product data here
//                 log(product.toString());
//                 return ItemCard(product: product);
//               },
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//               //  Text("Can't fetch Data"),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
