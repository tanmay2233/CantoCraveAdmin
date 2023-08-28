import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';

class AdminSearchPage extends StatefulWidget {
  const AdminSearchPage({super.key});

  @override
  State<AdminSearchPage> createState() => _AdminSearchPageState();
}

class _AdminSearchPageState extends State<AdminSearchPage> {
  List<Map<String, dynamic>> allItems = [];

  void fetchAllItemsFromFirebase(String query) async {
    final result =
        await FirebaseFirestore.instance.collection('Menu_Items').get();

    setState(() {
      allItems = result.docs
          .map((e) => {'id': e.id, ...e.data()}) 
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  String _editedQuantity = '';
  String _editedPrice = '';
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: Text(
          "Edit Item",
          style: TextStyle(color: MyTheme.fontColor),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          ),
        ),
      ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                  begin: Alignment.topCenter)),
          child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: MyTheme.cardColor),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyTheme.iconColor),
                        borderRadius: BorderRadius.circular(size.width * 0.04)),
                    suffixIcon: Icon(Icons.search_rounded),
                    suffixIconColor: MyTheme.fontColor,
                    hintText: "Search for an item...",
                    hintStyle: TextStyle(color: MyTheme.fontColor),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyTheme.iconColor))),
                onChanged: (query) {
                  fetchAllItemsFromFirebase(query);
                },
              ),
            ),
            Consumer<CartListProvider>(
              builder: (context, value, child) => Expanded(
                  child: ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.07)),
                    color: MyTheme.canvasDarkColor,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.black,
                            MyTheme.canvasLightColor,
                          ]),
                          borderRadius: BorderRadius.circular(size.width * 0.07),
                          border: Border.all(
                              color: const Color.fromARGB(179, 172, 169, 169))),
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.02),
                        child: SizedBox(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                              Image.network(
                                allItems[index]['image'],
                                width: size.width * 0.2,
                                height: size.height * 0.1,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: size.width * 0.26),
                                          child: Text(
                                            allItems[index]['name'] + " ",
                                            style: TextStyle(
                                                color: MyTheme.fontColor),
                                            maxLines: 4,
                                          ),
                                        ),
                                        Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(Icons.crop_square_sharp,
                                                  color: allItems[index]['isVeg']
                                                      ? Colors.green
                                                      : const Color.fromARGB(
                                                          202, 243, 57, 44),
                                                  size: size.width * 0.06),
                                              Icon(Icons.circle,
                                                  color: allItems[index]['isVeg']
                                                      ? Colors.green
                                                      : const Color.fromARGB(
                                                          202, 243, 57, 44),
                                                  size: size.width * 0.024),
                                            ])
                                      ]),
                                  Text("₹ ${allItems[index]['price']}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MyTheme.cardColor),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  MyTheme.canvasDarkColor,
                                              title: Text(
                                                "Update Item",
                                                style: TextStyle(
                                                    color: MyTheme.fontColor),
                                              ),
                                              content: Theme(
                                                data: MyLoginPageTheme
                                                    .loginPageTheme(context),
                                                child: SizedBox(
                                                  height: size.height * 0.14,
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            _priceController,
                                                        style: TextStyle(
                                                            color: MyTheme
                                                                .fontColor),
                                                        decoration: InputDecoration(
                                                            enabledBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyTheme
                                                                        .fontColor)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyTheme
                                                                        .fontColor)),
                                                            hintText:
                                                                "Enter new Price",
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                        maxLines: 1,
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.03),
                                                      TextField(
                                                        controller:
                                                            _quantityController,
                                                        style: TextStyle(
                                                            color: MyTheme
                                                                .fontColor),
                                                        decoration: InputDecoration(
                                                            enabledBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyTheme
                                                                        .fontColor)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyTheme
                                                                        .fontColor)),
                                                            hintText:
                                                                "Enter new Quantity",
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      _editedQuantity =
                                                          _quantityController
                                                              .text;
                                                      _editedPrice =
                                                          _priceController.text;

                                                      if (_editedPrice != '') {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Menu_Items')
                                                            .doc(allItems[index]['id'])
                                                            .update({
                                                          'price': double.parse(
                                                              _editedPrice)
                                                        });
                                                      }

                                                      if (_editedQuantity !=
                                                          '') {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Menu_Items')
                                                            .doc(allItems[index]
                                                                ['id'])
                                                            .update({
                                                          'quantity':
                                                              double.parse(
                                                                  _editedQuantity)
                                                        });
                                                      }

                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Update",
                                                      style: TextStyle(
                                                          color: MyTheme
                                                              .fontColor),
                                                    ))
                                              ],
                                            ));
                                  },
                                  child: Text("Edit",
                                      style: TextStyle(
                                          color: MyTheme.canvasDarkColor))),
                            ])),
                      ),
                    ),
                  );
                },
              )),
            )
          ],
              ),
        ),
      )
    );
  }
}