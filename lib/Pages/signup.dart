import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perfect/Pages/bottom_nav.dart';
import 'package:perfect/Pages/login.dart';
import 'package:perfect/services/database.dart';
import 'package:perfect/services/shared_pref.dart';
import 'package:random_string/random_string.dart';

import '../widgets/support_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String? name, email, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async{
    if (password!=null && name!=null && email!=null){
      try{
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent,
            content: Text("registered Successfully", style: TextStyle(color: Colors.black, fontSize: 16))));


        //Adding data to database firebase
        String Id= randomAlphaNumeric(10);

        await SharedPreferenceHelper().saveUserEmail(emailController.text);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserImage("https://firebasestorage.googleapis.com/v0/b/perfectnew-cc234.appspot.com/o/androgynous-avatar-non-binary-queer-person.jpg?alt=media&token=7a864647-6db0-4544-8753-7dcc00f56feb");


        Map<String, dynamic> userInfoMap= {
          "Name": nameController.text,
          "Email": emailController.text,
          "Password": passwordController.text,
          "Id": Id,
          "Image": "https://firebasestorage.googleapis.com/v0/b/perfectnew-cc234.appspot.com/o/androgynous-avatar-non-binary-queer-person.jpg?alt=media&token=7a864647-6db0-4544-8753-7dcc00f56feb"

        };
        await DatabaseMethods().addUserDetails(userInfoMap, Id);

        Navigator.push(context,MaterialPageRoute(builder: (context) => BottomNav()) );

      }on FirebaseException catch(e) {
        if(e.code=="weak"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("password provided is too weak", style: TextStyle(color: Colors.black, fontSize: 16))));
        }

        else if(e.code=="email already in use"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("account already exist", style: TextStyle(color: Colors.black, fontSize: 16))));

        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Image.asset("images/login.png"),
                  Text("SignUp", style: AppWidget.boldTextfieldStyle()
                  ),
              
              
                  SizedBox(height: 25,),
              
              
                  Text("Please input your correct details below.",style: AppWidget.lightTextStyle()),
                  SizedBox(height: 30,),
                  Text("Name", style: AppWidget.semiBoldTextStyle(),),
              
                  SizedBox(height: 18.0),
              
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                      child: TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your name';
                          }
                          return null;
                          },
                        controller: nameController,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Name"),
                      )),
              
              
                  SizedBox(height: 27,),
                  Text("Email", style: AppWidget.semiBoldTextStyle(),),
                  SizedBox(height: 18.0),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                      child:
                      TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                      )),
              
                  SizedBox(height: 27,),
                  Text("Password", style: AppWidget.semiBoldTextStyle(),),
                  SizedBox(height: 18.0),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                      child:
                      TextFormField(
                        obscureText: true,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Password"),
                      )),
              
                  SizedBox(height: 25,),
              
                  GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          name = nameController.text;
                          email = emailController.text;
                          password=passwordController.text;
                          registration();
                        });
                      }
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(14)),
                        width: MediaQuery.of(context).size.width/2,
                        child:
                        Center(
                          child: Text("SignUp", style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20
                          )
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?", style: AppWidget.lightTextStyle(),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => LogIn()) );
                          },
                          child: Text("SignIn",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)
                          )
                      )
                    ],
                  ),
              
                ],
              ),
            ),
          ),
        )
    );
  }
}
