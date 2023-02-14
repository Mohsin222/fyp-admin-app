import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:provider/provider.dart';

import '../providers/find_food_provider.dart';
import '../views/food_detailsitem_details_screen.dart';

class HomePopularCard extends StatefulWidget {


  @override
  State<HomePopularCard> createState() => _HomePopularCardState();
}

class _HomePopularCardState extends State<HomePopularCard> with SingleTickerProviderStateMixin  {

  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      
      duration: Duration(seconds: 1),
    );
    _animationController!.forward();
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FindFood>(
      builder: (context, value, child) {

        return  Container(
          
            margin: EdgeInsets.symmetric(horizontal: 5),
  
            color: Theme.of(context).scaffoldBackgroundColor,
            child: GridView.custom(
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(
        
           ),
    gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing:0,
            pattern: [
              WovenGridTile(0.6),
              WovenGridTile(
            6/ 11,
            crossAxisRatio: 1,
            
            alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
childCount:value.getFilteredData().length,
  (context, index){
      FoodItem foodItem =
                               value.getFilteredData()[index];
           if(value.getFilteredData().length >0){

            return AnimatedBuilder(
                   animation: _animationController!,
                  builder: (context, child) {
                    return Transform(
                 
                           transform: Matrix4.translationValues(
                 
                  0.0,
                   _animation!.value * 100,
                  0.0,
                ),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FoodItemDetailScreen(foodItem: foodItem),));
                      },
                      child: Container(
                             
                         
                            
                                    // clipBehavior: Clip.antiAlias,
                                    // // shape: ShapeBorder(),
                                    // semanticContainer: true,
                                    // shadowColor: Colors.black,
                                    // borderOnForeground: false,
                                    // elevation: 10,
                                
                                    child: Column(
                            children: [
                                    Expanded(child: value.singlefoodloading ==true?
                                    Center(child: CircularProgressIndicator(),)
                                    :Container(
                                      
                                      clipBehavior: Clip.antiAlias,
                                      // width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                      child: Image(image: NetworkImage(foodItem.picture.toString()),fit: BoxFit.cover,),),),
                                    
                        
                                      Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(foodItem.name.toString().toUpperCase(),style: TextStyle(color: Colors.white),),
                                      ),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              alignment: Alignment.centerLeft,
                      child: Text(foodItem.price.toString(),style: TextStyle(color: Colors.white),),
                                      ),
                            ],
                                    ),
                            ),
                    )  ,
                      )  ;
                  },
                 );


           }else{
            return Center(child: Text('No Data',style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white)),);
           }                     

  }
            
          ),

            ),
        );
 
      },
    );
  }
}


