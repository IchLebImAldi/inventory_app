import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/pages/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Navigator.popAndPushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        elevation: 0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text("Add Item"),
            onPressed: () {
              Navigator.pushNamed(context, "/item");
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('inventory_products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
              children: snapshot.data.documents.map((document) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                        child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.album, size: 60),
                            title: Text(document['title'],
                                style: TextStyle(fontSize: 30.0)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Expire Date: "+dateFormat.format(dateFormat.parse(document['expiring_date'])).toString(),
                                    style: TextStyle(fontSize: 18.0)),
                                Text("Quantity: "+document['quantity'],
                                style: TextStyle(fontSize: 18.0)),
                              ],
                            ),
                            
                          ),
                          
                          ButtonBar(
                            children: <Widget>[
                              RaisedButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  print(document['title']);
                                  setState(() {
                                     Firestore.instance.collection('inventory_products').document(document['title']).delete();
                                  });
                                 
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            );
          }).toList());
        },
      ),
    );
  }
}
