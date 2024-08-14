import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perfect/Admin/admin_login.dart';
import 'package:perfect/Pages/bottom_nav.dart';
import 'package:perfect/Pages/signup.dart';
import 'package:perfect/widgets/support_widget.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  String email="", password="";

  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();

  final _formkey= GlobalKey<FormState>();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text("Login Successfully",
              style: TextStyle(color: Colors.black, fontSize: 16))));

      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseException catch (e) {
      if (e.code == "user-not") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text("user not registered",
                style: TextStyle(color: Colors.black, fontSize: 16))));
      }else if(e.code=="wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text("wrong password",
                style: TextStyle(color: Colors.black, fontSize: 16))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
                onTap: () { Navigator.pop(context);},
                child: Icon(Icons.arrow_back_ios_new_outlined)),
            title: GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => Admin()));
              },
              child: Align(
                alignment: Alignment.centerRight,
                  child: Text("Admin Login", style: AppWidget.semiBoldTextStyle())),
            )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("images/login.png"),
                Text("SignIn", style: AppWidget.boldTextfieldStyle()
                ),


                SizedBox(height: 25,),


                Text("Please input your correct details below.",style: AppWidget.lightTextStyle()),
                SizedBox(height: 30,),
                Text("Email", style: AppWidget.semiBoldTextStyle(),),

                SizedBox(height: 18.0),

                Container(

                    padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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

                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forget Password", style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),

                SizedBox(height: 25,),

                GestureDetector(
                    onTap: (){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          email=emailController.text;
                          password=passwordController.text;
                          userLogin();
                        });
                      }

                    }, child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(14)),
                      width: MediaQuery.of(context).size.width/2,
                      child: Center(
                          child: Text("Login", style: TextStyle(
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
                    Text("Don't have an account ?", style: AppWidget.lightTextStyle(),),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()) );
                          },
                        child: Text("SignUp", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500, fontSize: 18),))
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
