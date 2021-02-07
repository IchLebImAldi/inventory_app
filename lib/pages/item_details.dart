import 'package:flutter/material.dart';
import 'package:inventory_app/item.dart';

class ItemDetails extends StatefulWidget {
  int id = 0;
  ItemDetails({this.id});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {

  List<Item> itemList = [
    Item(title: "Cristaline", barcode: 02040240, expiringDate: DateTime.now(), quantity: 2),
    Item(title: "Snickers", barcode: 2352525, expiringDate: DateTime.now(), quantity: 22),
    Item(title: "Viva", barcode: 23556, expiringDate: DateTime.now(), quantity: 42),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text(itemList[widget.id].title),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Card(
              margin: EdgeInsets.all(16),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  itemList[widget.id].title
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
