class ContactUs{
 late String name;
 late String description;
 late DateTime date;
 late String email;
  late String contactNumber;

  ContactUs({required this.name,required this.email,required this.date,required this.description,required this.contactNumber});

ContactUs.fromMap(Map<String,dynamic> map){
  name=map['name'];
  description=map['description'];
  date  =map['date'].toDate();
  email =map['email'];
  contactNumber =map['contactNumber'];


}

Map<String, dynamic> toMap(){
  return {
    "name":name,
    "description":description,
    "date":date,
    "email":email,
    "contactNumber":contactNumber

  };
}

}