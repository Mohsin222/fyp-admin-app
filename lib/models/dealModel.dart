class DealModel{

String? dealNo;
String? item1;
String? item2;
String? item3;
String? item4;
int? price;
int? discount;
String? uid;
String? picture;


DealModel({this.dealNo,this.item1,this.item2,this.item3,this.item4,this.price,this.discount,this.uid,required this.picture});

 DealModel.fromMap(Map<String, dynamic> map){
  dealNo =map['dealNo'];
  item1 =map['item1'];
  item2 =map['item2'];
  item3 =map['item3'];
  item4 =map['item4'];
  price =map['price'];
  discount=map['discount'];
  uid=map['uid'];
  picture=map['picture'];
 }

 Map<String, dynamic> toMap(){
  return {
    "dealNo":dealNo,
    "item1":item1,
    "item2":item2,
    "item3":item3,
    "item4":item4,
    "price":price,
    "discount":discount,
    'uid':uid,
    'picture':picture



  };
 }




}