import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:perfect/services/constant.dart';
import 'package:perfect/services/database.dart';
import 'package:perfect/services/shared_pref.dart';
import 'package:perfect/widgets/support_widget.dart';
import 'package:http/http.dart'as http;

class ProductDetail extends StatefulWidget {
  String image, name, detail, price;
  ProductDetail({required this.image, required this.name, required this.detail, required this.price});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? name, mail, image;

  getthesharedpref() async{
    name= await SharedPreferenceHelper().getUserName();
    mail= await SharedPreferenceHelper().getUserEmail();
    image= await SharedPreferenceHelper().getUserImage();
    setState(() {

    });
  }

  ontheLoad() async{
    await getthesharedpref();
    setState(() {

    });
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        padding: EdgeInsets.only(top: 54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(32)),
                  ),
                ),
                Center(child: Image.network(widget.image, height: 420,)),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 26, left: 20, right: 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name ,style:AppWidget.boldTextfieldStyle(),
                        ),
                        Text("\$" + widget.price,
                            style: TextStyle(color: Colors.orange, fontSize: 24, fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 21,),
                    Text("Details", style: AppWidget.semiBoldTextStyle(),),
                    SizedBox(height: 16,),
                    Text(widget.detail),
                    SizedBox(height: 130,),
                    GestureDetector(
                      onTap: (){
                        makePayment(widget.price);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(14)),
                        width: MediaQuery.of(context).size.width,
                        child:
                        Center(
                          child: Text("Buy Now", style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20
                          )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async{
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secret'],
              style: ThemeMode.dark, merchantDisplayName: 'Aarav'
          )).then((value) {

      });
      displayPaymentSheet();
      }catch(e,s){
        print('exception:$e$s');
      }
  }

  displayPaymentSheet()async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value) async{

        //code for updating order into firebase
        Map<String, dynamic> orderInfoMap={
          "Product": widget.name,
          "Price": widget.price,
          "Name": name,
          "Email": mail,
          "Image": image,
          "ProductImage": widget.image,
        };
        await DatabaseMethods().orderDetails(orderInfoMap);

        showDialog(context: context, builder: (_) => AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green,),
                Text("Payment Successfull")
              ],
            )

            ],
          ),
        ));
        paymentIntent=null;
      }).onError((error, stackTrace){
        print("Error is :---> $error $stackTrace");
      });
    } on StripeException catch(e){
      print("Error is:---> $e");
      showDialog(context: context, builder: (_) => AlertDialog(
        content: Text("Cancelled"),
      ));
    } catch(e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency)async{
    try{
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]':'card'
      };

      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization': 'Bearer $secretkey',
            'Content-Type': 'application/x-www-form-urlencoded'
      },body: body,
      );
      return jsonDecode(response.body);
    }catch(err){
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount){
    final calculatedAmount=(int.parse(amount)*100);
    return calculatedAmount.toString();
  }

}
