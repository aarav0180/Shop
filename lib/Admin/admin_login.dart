import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect/Admin/add_products.dart';
import 'package:perfect/Admin/home_admin.dart';
import 'package:perfect/Pages/bottom_nav.dart';
import 'package:perfect/Pages/login.dart';
import 'package:perfect/widgets/support_widget.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  TextEditingController usernameController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
          child: Column(
            children: [
              Image.asset("images/login.png"),
              Text("Admin Panel", style: AppWidget.boldTextfieldStyle()
              ),


              SizedBox(height: 25,),

              SizedBox(height: 30,),
              Text("Username", style: AppWidget.semiBoldTextStyle(),),

              SizedBox(height: 18.0),

              Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "UserName"),
                  )),


              SizedBox(height: 27,),
              Text("Password", style: AppWidget.semiBoldTextStyle(),),
              SizedBox(height: 18.0),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child:
                  TextFormField(
                    obscureText: true,
                    controller: userpasswordController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  )),

              SizedBox(height: 25,),

              GestureDetector(
                onTap: () {
                  loginAdmin();
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 17),
                    decoration: BoxDecoration(color: Colors.green,
                        borderRadius: BorderRadius.circular(14)),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    child:
                    Center(
                      child: Text("LogIn", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
  
  loginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['Username'] != usernameController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("Username is not correct",
                  style: TextStyle(color: Colors.black, fontSize: 16))));
        }else if(result.data()['Password'] != userpasswordController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("Password is not correct",
                  style: TextStyle(color: Colors.black, fontSize: 16))));
        }
        else {
          Navigator.push(context,MaterialPageRoute(builder: (context) => AddProducts()));
        }
      });
    });
  }
}
