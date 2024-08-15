import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods{

  Future addUserDetails(Map<String, dynamic> userInfoMap, String id)async{
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addProducts(Map<String, dynamic> userInfoMap, String categoryname)async{
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  Future  <Stream<QuerySnapshot>> getProducts(String category) async{
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future  <Stream<QuerySnapshot>> getOrders(String email) async{
    return await FirebaseFirestore.instance.collection("Orders").where("Email", isEqualTo: email).snapshots();
  }

  Future orderDetails(Map<String, dynamic> userInfoMap)async{
    return await FirebaseFirestore.instance
        .collection("Orders")
        .add(userInfoMap);
  }
}