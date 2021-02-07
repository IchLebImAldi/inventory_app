import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/pages/create_item.dart';
import 'package:inventory_app/pages/home.dart';
import 'package:inventory_app/pages/item_details.dart';
import 'package:inventory_app/pages/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 

  runApp(MaterialApp(
    initialRoute: "/home",
    routes: {
      // "/": (context) => Loading(),
      "/home": (context) => Home(),
      "/item": (context) => CreateItem(),
      "/item_details": (context) => ItemDetails()
    },
  ));
}

// class Home extends StatefulWidget {
//   Home({Key key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<Item> customItems = [
//     Item(
//         title: "Test Item",
//         barcode: 02020,
//         expiringDate: DateTime.now(),
//         quantity: 2),
//     Item(
//         title: "Test Item 2",
//         barcode: 0420924,
//         expiringDate: DateTime.now(),
//         quantity: 24)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Inventory", style: TextStyle(color: Colors.black),),
//         elevation: 0,
//         backgroundColor: Colors.grey[200],
//       ),
//       body: Column(
//         children: customItems.map((item) => ItemCard(
//           item: item,
//           delete: (index) {
//             setState(() {
//               customItems.remove(item);
//             });
//           }
//         )).toList(),
//       ),
//     );
//   }
// }


