import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect/Pages/product_detail.dart';
import 'package:perfect/services/database.dart';
import 'package:perfect/widgets/support_widget.dart';

class CategoryProduct extends StatefulWidget {
  String category;
  CategoryProduct({required this.category});


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {

  Stream? CategoryStream;

  getOnTheLoad() async{
    CategoryStream = await DatabaseMethods().getProducts(widget.category);
    setState(() {

    });
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allProducts(){
    return StreamBuilder(stream: CategoryStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6, mainAxisSpacing: 10.0, crossAxisSpacing: 10), itemCount: snapshot.data.docs.length, itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];


            return Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: EdgeInsets.only(right: 20, left: 20),
              child:
              Column(children: [
                Image.network(ds["Image"], height: 120.0, width: 120.0, fit: BoxFit.cover,),
                Text(ds["Name"], style: AppWidget.semiBoldTextStyle(),),
                Row(
                  children: [
                    Text("\$"+ds["Price"], style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(width: 40.0,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>ProductDetail(image: ds["Image"], name: ds["Name"], detail: ds["Detail"], price: ds["Price"])));
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.orange),
                          child: Icon(Icons.add, color: Colors.white)),
                    )
                  ],
                )
              ],),);
      }): Container();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(backgroundColor: Color(0xfff2f2f2),),
      body: Container(
        child: Column(
          children: [
            Expanded(child: allProducts()),

          ],
        ),
      ),
    );
  }
}
