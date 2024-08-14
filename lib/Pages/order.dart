import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect/widgets/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  Stream? orderStream;

  Widget allOrders() {
    return StreamBuilder(
        stream: orderStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];


            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: EdgeInsets.only(right: 20, left: 20),
              child:
              Column(children: [
                Image.network(
                  ds["Image"], height: 120.0, width: 120.0, fit: BoxFit.cover,),
                Text(ds["Name"], style: AppWidget.semiBoldTextStyle(),),
                Row(
                  children: [
                    Text("\$" + ds["Price"], style: TextStyle(color: Colors
                        .orange, fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(width: 40.0,),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.orange),
                          child: Icon(Icons.add, color: Colors.white)),
                    )
                  ],
                )
              ],),);
          }) : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(title: Text("Current Orders", style: AppWidget.boldTextfieldStyle(),),
          backgroundColor: Color(0xfff2f2f2),),
      body: Container (
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
