import 'package:flutter/material.dart';

class FoodItem{

  String? name;
  String? picture;
  double? price;
  String? description;
  bool? available;
  String? uid;
  bool? popular;
  String? foodType;
  String? category;
  int? discount;
  String? size1;
  String? size2;
  FoodItem({
    required this.name,
    required this.description,
    this.picture,
    required this.price,
    required this.available,
    required this.uid,
    this.popular,
    required this.foodType,
    required this.category,
     this.discount,
     this.size1,
     this.size2
    
    });


    FoodItem.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    name =map["name"];
    description=map["description"];
    available =map['available'];
    price =map["price"];
    popular=map['popular'];
    picture=map['picture'];
    foodType=map['foodType'];
    category=map['category'];
    discount=map['discount'];
    size1=map['size1'];
    size2=map['size2'];

    }
  Map<String, dynamic> toMap(){
    return {
         "uid": uid,
         "name":name,
         "description":description,
         "available":available,
         "price":price,
         "popular":popular,
         "picture":picture,
         "foodType":foodType,
         "category":category,
         "discount":discount,
         'size1':size1,
         'size2':size2,

    };
  }
}