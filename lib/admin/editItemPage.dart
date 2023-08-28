import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Theme/themes.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({super.key});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  @override
  Widget build(BuildContext context) {
    String _editedQuantity = '';
    String _editedPrice = '';
    TextEditingController _quantityController = TextEditingController();
    TextEditingController _priceController = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: Text("Edit Items", style: 
          TextStyle(color: MyTheme.cardColor)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: 
            [MyTheme.canvasLightColor, MyTheme.canvasDarkColor])
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor],
                  begin: Alignment.topCenter)),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Menu_Items').snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: MyTheme.fontColor,
                      ));
                    }
                    List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              
                  return Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                        String? documentId = snapshot.data?.docs[index].id; 
                          return Padding(
                            padding: EdgeInsets.all(size.width * 0.018),
                            child: GridTile(
                                child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image(
                                      image: NetworkImage(documents[index]['image']),
                                      height: size.height * 0.12,
                                    ),
                                  ],
                                ),
                                GridTileBar(
                                    title: Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            documents[index]['name'],
                                            maxLines: 3,
                                            style: TextStyle(color: MyTheme.fontColor),
                                          )),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(
                                                Icons.crop_square_sharp,
                                                color: documents[index]['isVeg']
                                                  ? Colors.green
                                                  : const Color.fromARGB(202, 243, 57, 44),
                                                size: size.width * 0.06,
                                              ),
                                              Icon(Icons.circle,
                                                  color: documents[index]['isVeg']
                                                    ? Colors.green
                                                    : const Color.fromARGB(202, 243, 57, 44),
                                                  size: size.width * 0.024),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("₹ "+documents[index]['price'].toString(),
                                        style: const TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: size.height*0.025,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: MyTheme.cardColor),
                                            onPressed: (){
                                            showDialog(context: context,
                                              builder: (context) => AlertDialog(
                                                
                                                backgroundColor: MyTheme.canvasDarkColor,
                                                title: Text(
                                                  "Update Item",
                                                  style: TextStyle(color: MyTheme.fontColor),
                                                ),
                                                content: Theme(
                                                  data: MyLoginPageTheme.loginPageTheme(context),
                                                  child: SizedBox(
                                                    height: size.height*0.14,
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          controller: _priceController,
                                                          style: TextStyle(color: MyTheme.fontColor),
                                                          decoration: InputDecoration(
                                                              enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: MyTheme.fontColor)),
                                                              focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: MyTheme.fontColor)),
                                                              hintText:
                                                                  "Enter new Price",
                                                              hintStyle:
                                                                  const TextStyle(
                                                                      color:Colors.white)),
                                                          maxLines: 1,
                                                        ),

                                                        SizedBox(height: size.height*0.03),
                                                  
                                                        TextField(
                                                          controller: _quantityController,
                                                          style: TextStyle(
                                                            color: MyTheme.fontColor),
                                                            decoration: InputDecoration(
                                                              enabledBorder:
                                                                UnderlineInputBorder(borderSide: BorderSide(color: MyTheme.fontColor)),
                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyTheme.fontColor)),
                                                              hintText: "Enter new Quantity",
                                                              hintStyle: const TextStyle(color: Colors.white)),
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed:
                                                      () async {
                                                        _editedQuantity = _quantityController.text;
                                                        _editedPrice = _priceController.text;

                                                        if(_editedPrice != ''){await FirebaseFirestore.instance
                                                          .collection('Menu_Items').doc(documentId).update({
                                                            'price': double.parse(_editedPrice)
                                                        });}

                                                        if(_editedQuantity != ''){await FirebaseFirestore.instance
                                                          .collection('Menu_Items').doc(documentId).update({
                                                            'quantity': double.parse(_editedQuantity)
                                                          });}

                                                      Navigator.pop(context);
                                                    },
                                                      child: Text("Update",
                                                        style: TextStyle(color: MyTheme.fontColor),
                                                    )
                                            )
                                                ],
                                              )
                                            );
                                          }, 
                                          child: Text("Edit", style: 
                                            TextStyle(color: MyTheme.canvasDarkColor))),
                                        )
                                      ],
                                    )
                                  ),
                              ],
                            )),
                          );
                        },
                      ),
                    );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}