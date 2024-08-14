import 'package:flutter/material.dart';
import 'package:perfect/widgets/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
