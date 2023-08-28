
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Theme/themes.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

  void deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('newOrders').doc(orderId).delete();
    } catch (e) {
      print('Error deleting order: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
          )
        )
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('newOrders').orderBy('orderDate', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: MyTheme.cardColor),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text("No Orders Placed Till Now"));
          }
          var ordersList = snapshot.data?.docs;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
            ),
            child: ListView.builder(
              itemCount: ordersList?.length,
              itemBuilder: (context, index) {
                var orderData = ordersList?[index].data() as Map<String, dynamic>?;

                return Padding(
                  padding: EdgeInsets.only(bottom: size.width*0.03, 
                    top: size.width * 0.01, left: size.width*0.02, right: size.width * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(size.width*0.03),
                    ),
                    padding: EdgeInsets.all(size.width*0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${orderData?['username']}",
                            style: TextStyle(
                                color: MyTheme.cardColor,
                                fontWeight: FontWeight.bold)),
                        Text("Id: ${orderData?['orderId']}",
                            style: TextStyle(color: Colors.white)),
                        Text(
                          "Ordered on: ${DateFormat("EEEE dd/MM/yyyy HH:mm").format(orderData?['orderDate'].toDate())}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Divider(height: 3, color: MyTheme.cardColor),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderData?['items'].length,
                          separatorBuilder: (context, index) => Container(),
                          itemBuilder: (context, index2) {
                            var item = orderData?['items'][index2];
                            return Padding(
                              padding: EdgeInsets.all(size.width*0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.iconColor),
                                  borderRadius: BorderRadius.circular(size.width*0.04),
                                  gradient: LinearGradient(
                                    colors: [MyTheme.canvasDarkColor, MyTheme.canvasLightColor])),
                                child: Padding(
                                  padding: EdgeInsets.all(size.width * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        item['image'],
                                        width: size.width * 0.12,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            item['name'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: MyTheme.cardColor),
                                          ),
                                          Text("${item['quantity']} unit(s)",
                                              style:
                                                  TextStyle(color: MyTheme.iconColor))
                                        ],
                                      ),
                                      Text("₹ ${item['price']}",
                                        style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: (){
                              showDialog(context: context, builder: 
                              (context) => AlertDialog(
                                backgroundColor: MyTheme.canvasDarkColor,
                                title: Text("Order Completed", style: TextStyle(
                                  color: MyTheme.cardColor,
                                  fontWeight: FontWeight.bold
                                )),
                                content: Text("This order would be removed",
                                style: TextStyle(color: MyTheme.fontColor)),
                                
                                actions: [
                                  TextButton(onPressed: () {
                                    deleteOrder(ordersList![index].id);
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("OK", style: TextStyle(
                                    color: MyTheme.fontColor
                                  ),)),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },

                                    child: Text(
                                      "Wait",style: TextStyle(
                                        color: MyTheme.fontColor),
                                    ))
                                ],
                              ),
                              );
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                    BorderRadius.circular(size.width * 0.05),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 255, 208, 0),
                                    Color.fromARGB(255, 252, 248, 50)
                                  ])),
                                width: size.width * 0.5,
                                height: size.height * 0.04,
                                child: Text(
                                  "Order Completed",style: TextStyle(
                                    color: MyTheme.canvasDarkColor,
                                    fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      )

      ),
    );
  }
}