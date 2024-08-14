import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect/Pages/login.dart';
import 'package:perfect/widgets/support_widget.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 231),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/headphone.PNG"),
              Padding(
                  padding: const EdgeInsets.only(left: 30.0),
              child : Text("Explore\nThe Best\nProducts",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold)
              )
              ),
              SizedBox(height: 30.0, width: 60),
              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],),),
    );
  }
}


    