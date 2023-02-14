import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/views/viewallfood.dart';
import 'package:fyp_app/widgets/appbar.dart';
import 'package:fyp_app/widgets/category_list.dart';

import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';


import '../models/dealModel.dart';

import '../providers/auth_provider.dart';
import '../providers/find_food_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/grid_vi.dart';
import '../widgets/home_popular_card.dart';
import 'deal_detail_screen.dart';
import 'deals_details.dart';

class HomeScreen extends StatelessWidget {

var x=0;


ScrollController scrollController =ScrollController();
  @override
  Widget build(BuildContext context) {
    final findfood =Provider.of<FindFood>(context,listen: false);
    // findfood.getListOfFood();
    
    return Scaffold(
      // backgroundColor: Color.fromRGBO(255, 255, 255, 1),

    //  bottomNavigationBar: AddWidget(),
      appBar:AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).cardColor,
        
             leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ),
      // drawer: Container(
      //   width: MediaQuery.of(context).size.width/1.5,
      //   child: DrawerWidget()),
      

      body: Container(
         height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          // child: Column(
          //   children: [
          //     Container(
          //       width: 200,
          //       height: 100,
          //       color: Colors.red,
          //       child: Text('1'),
          //     ),
          //      Container(
          //         width: 200,
          //       height: 600,
          //       color: Colors.black,
          //         child: Text('1'),
          //     ),
          //      Container(
          //         width: 200,
          //       height: 400,
          //       color: Colors.green,
          //         child: Text('1'),
          //     ),
          //   ],
          // ),
          child: Column(
            children: [
              
       
                     Container(
                      height: 100,
                             margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    text:TextSpan(
                    text: 'Choose Your Delecious ',
                    // style:  TextStyle(
                    //   color: Colors.black,
                    //         fontSize: 28,
                    //         fontWeight: FontWeight.w700
                    //       ),
                    style: Theme.of(context).textTheme.headline1,
                          children: [
                            TextSpan(
                              text: 'Food',
                               style:  TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1fc9b1)
                          ),
                            ),
                          ]
                  ) ),
                ),

                //search container
                      Container(
                        constraints: BoxConstraints(minHeight: 80),
                      height:80 ,
                          margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Consumer<FindFood>(

                          builder: (context, food, child) {
                            return TextField(
                         
                              onChanged: (value){
                                food.searchQuery =value;
                                print(food.searchcategory);
                food.selectCategory(food.searchQuery);
                              },
                              
                          decoration:InputDecoration(
                            prefixIcon: null,
                            filled: true,
                            fillColor: Color(0xfff7f7f7),
                            prefix: Icon(Icons.search,),
                            
                         contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            
                             border: OutlineInputBorder(),
                                 enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(20),
                                 
                                 ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange,),
                borderRadius: BorderRadius.circular(20),
                ),
                          ) ,
                        );
                          },
                        )
                      ),

//deals heading
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Normalheading(text: 'Deals'),

                    InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: TitPage()));

                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return DealsDetailScreen();
                        // }));
                      },
                      child: Text('View All',style: TextStyle(color: Colors.white),))
                  ],
                ),
                Container(
                  
                  height: 110,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  // border: Border.all()
                  ),
                  child: Consumer<FindFood>(
          
                    builder: (context, value,child) {
                      if(value.allDeals.length >0){
                        return ListView.builder(
                        itemCount: value.allDeals.length,
                        scrollDirection: Axis.horizontal,
                           
                        itemBuilder: (context,index){
                               DealModel dealModel =value.allDeals[index];
                          return InkWell(
                            onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DealsDetailScreen(dealModel: dealModel,)));
                            },
                            child: Container(
                                    
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                 image: DecorationImage(image: NetworkImage(dealModel.picture.toString()),fit: BoxFit.cover),
                                 
                                                border: Border.all(),
                                                
                                                ),
                                                constraints: BoxConstraints(minWidth: 100),
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Deal ${dealModel.dealNo}',style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),)),
                          );
                        });
                      }else{
                        return Center(
                          child: Text('No Deals',style: Theme.of(context).textTheme.headline3,),
                        );
                      }
                    }
                  )
                  
                ),
                //category heading
                Normalheading(text: 'Categories'),
                             CategoryList(height: 130,radius: 35,),
        
                   Container(
                                  // color: Colors.white,
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                          
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text('Popular',style: Theme.of(context).textTheme.headline2),
                        ),
                        InkWell(
                          onTap: () {
                                 final prov = Provider.of<FindFood>(context,listen: false);
                              prov.getListOfFood();
                                 Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: ViewAllFoodScreen()));

                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFoodScreen()));
                          },
                          child: Text('View All',style: TextStyle(color: Colors.white)))
                      ],
                      
                     ),
                   ),

                   //last grid product
              Container(
                height: 300,
               
                //  color: Colors.white,
  
                child: HomePopularCard()),
            ],
          ),
        ),
      ),
    );
  }
}

class Normalheading extends StatelessWidget {
  final String text;
  const Normalheading({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(text,style: Theme.of(context).textTheme.headline2),
            );
  }
}