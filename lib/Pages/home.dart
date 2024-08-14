import 'package:flutter/material.dart';
import 'package:perfect/Pages/category_products.dart';
import 'package:perfect/services/shared_pref.dart';
import 'package:perfect/widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png"
  ];

  List category = [
    "Headphones",
    "laptop",
    "watch",
    "TV",
  ];

  String? name, image;

  getthesharedpref()async{
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: name == null? Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey!"+ name!,
                        style: AppWidget.boldTextfieldStyle()),
        
                      Text("Good Morning",
                          style: AppWidget.lightTextStyle()),
                    ],
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(image!, height: 70.0, width: 70.0, fit: BoxFit.cover))
                ],
              ),
              SizedBox(height: 30.0,),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none, hintText: "Search Products", hintStyle: AppWidget.lightTextStyle(), suffixIcon: Icon(Icons.search, color: Colors.black,)),
                  )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories",
                      style: AppWidget.semiBoldTextStyle()),
                  Text("See all",
                      style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w500))
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                //margin: EdgeInsets.only(left: 20.0),
                height: 160,
                child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return CategoryTile(image: categories[index], name: category[index],);
                    }),
              ),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Products",
                      style: AppWidget.semiBoldTextStyle()),
                  Text("See all",
                    style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w500))
                ],
              ),
              SizedBox(height: 30.0,),
              Container(
                height: 240,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin: EdgeInsets.only(right: 20),
                    child:
                    Column(children: [
                      Image.asset("images/headphone2.png", height: 120.0, width: 120.0, fit: BoxFit.cover,),
                      Text("Headphones", style: AppWidget.semiBoldTextStyle(),),
                      Row(
                        children: [
                          Text("\$150", style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(width: 40.0,),
                          Container(
                            padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(color: Colors.orange),
                              child: Icon(Icons.add, color: Colors.white))
                        ],
                      )
                    ],),),
        
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: EdgeInsets.only(right: 20),
                      child:
                      Column(children: [
                        Image.asset("images/watch2.png", height: 120.0, width: 120.0, fit: BoxFit.cover,),
                        Text("Watch", style: AppWidget.semiBoldTextStyle(),),
                        Row(
                          children: [
                            Text("\$50", style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),),
                            SizedBox(width: 40.0,),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Colors.orange),
                                child: Icon(Icons.add, color: Colors.white))
                          ],
                        )
                      ],),),
        
        
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: EdgeInsets.only(right: 20),
                      child:
                      Column(children: [
                        Image.asset("images/headphone2.png", height: 120.0, width: 120.0, fit: BoxFit.cover,),
                        Text("Headphones", style: AppWidget.semiBoldTextStyle(),),
                        Row(
                          children: [
                            Text("\$150", style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),),
                            SizedBox(width: 40.0,),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Colors.orange),
                                child: Icon(Icons.add, color: Colors.white))
                          ],
                        )
                      ],),),
        
        
        
        
                ],),
              )
            ],
          )
        ),
      ),
    );
  }
}


class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryProduct(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        height: 110.0,
        width: 110.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Image.asset(image , height: 70.0, width: 70.0, fit: BoxFit.cover,),
          SizedBox(height: 20.0,),
          Icon(Icons.arrow_forward)
        ],),
      ),
    );
  }
}

