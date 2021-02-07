import 'package:flutter/material.dart';
import 'package:inventory_app/pages/item_details.dart';

import 'item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Function delete;
  ItemCard({this.item, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              item.title,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 6),
            Text(
              item.expiringDate.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            SizedBox(height: 8),
            FlatButton.icon(
              onPressed: () {
                delete(item);
              },
              label: Text("Delete"),
              icon: Icon(Icons.delete),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetails(id: item.id)));
              },
              label: Text("Details"),
              icon: Icon(Icons.details_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
