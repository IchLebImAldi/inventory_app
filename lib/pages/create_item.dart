import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CreateItem extends StatefulWidget {
  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  TextEditingController title_controller = new TextEditingController();
  TextEditingController barcode_controller = new TextEditingController();
  TextEditingController quantity_controller = new TextEditingController();
  TextEditingController expiring_date_controller = new TextEditingController();

  Map test = {
    'title': "TITLE",
    'barcode': 0,
    'quantity': 0,
    'expiring_date': DateTime.now(),
    'id': 0
  };

  String barcode = "BARCODE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text("Create new Item"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Column(
            children: [
              SizedBox(height: 20),
              Card(
                  margin: EdgeInsets.all(16),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: title_controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter a title"),
                        ),
                      ],
                    ),
                  )),
              Card(
                  margin: EdgeInsets.all(16),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: barcode_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: barcode),
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_enhance), 
                          onPressed: (){scanBarcode();}
                        )
                      ],
                    ),
                  )),
              Card(
                  margin: EdgeInsets.all(16),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: quantity_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter the amount"),
                        ),
                      ],
                    ),
                  )),
              Card(
                  margin: EdgeInsets.all(16),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          readOnly: true,
                          controller: expiring_date_controller,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2200)
                            ).then((date) {
                              setState(() {
                                expiring_date_controller.text = date.toString();
                              });
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter the Expiringdate"),
                        ),
                      ],
                    ),
                  )),
              FlatButton.icon(
                  onPressed: () {
                    // add NEW item to database --> products
                    Firestore.instance
                        .collection('products')
                        .document(barcode_controller.text)
                        .setData({
                      'ids': FieldValue.arrayUnion([
                        {
                          'title': title_controller.text,
                          'barcode': barcode_controller.text,
                        }
                      ])
                    });

                    // add item to database --> inventory_products
                    Firestore.instance
                        .collection('inventory_products')
                        .document(title_controller.text)
                        .setData(
                        {
                          'title': title_controller.text,
                          'barcode': barcode_controller.text,
                          'expiring_date': expiring_date_controller.text,
                          'quantity': quantity_controller.text,
                        }
                      
                    );

                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.save),
                  label: Text("Create new Item"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.BARCODE);

      if (!mounted) return;

      setState(() {
        this.barcode = barcode;
        barcode_controller.text = barcode;
      });
    } on PlatformException {
      barcode = 'Failed to scan Barcode!';
      barcode_controller.text = barcode;
    }
  }
}
