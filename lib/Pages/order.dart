import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect/services/database.dart';
import 'package:perfect/services/shared_pref.dart';
import 'package:perfect/widgets/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? email;

  getthesharedpref()async{
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {

    });
  }

  Stream? orderStream;

  getontheLoad() async{
    orderStream = await DatabaseMethods().getOrders(email!);
  }

  @override
  void initState() {
    getontheLoad();
    super.initState();
  }

  Widget allOrders() {
    return StreamBuilder(
        stream: orderStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];


            return Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [Row(
                    children: [
                      Image.network(ds["ProductImage"], height: 130, width: 130, fit: BoxFit.cover,),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(ds["Product"], style: AppWidget.semiBoldTextStyle(),),
                          Text("\$" + ds["Price"], style: TextStyle(color: Colors
                              .orange, fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      )
                    ],
                  )],
                ),
              ),
            );
          })
          : Container();
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
            Expanded(child: allOrders())
          ],
        ),
      ),
    );
  }
}
