import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/find_food_provider.dart';


class CategoryList extends StatelessWidget {
  final double height;
  final double radius;

   CategoryList({super.key, required this.height, required this.radius,});
  var x=0;

  @override
  Widget build(BuildContext context) {
    return Container(
                                  child: Consumer<FindFood>(
                         
                                    builder: (context, value,child) {
                                      return SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Container(
                                                       height:height,
                                                          child: Row(
                                                            children: List.generate(value.categoryIcon.length,(val){
                                                              return  Container(
                                      margin: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                           InkWell(
                                            onTap: (){
                                              x=val;
                                            value.selectCategory(value.categorytext[val]);
                                              print(value.categorytext[val]);
                                              value.updateSearchQuery(value.categorytext[val]);
                                            },
                                             child: CircleAvatar(
                                              backgroundColor: Theme.of(context).cardColor,
                                              radius: radius,
                                              backgroundImage: AssetImage(
                                                value.foodImages[val]
                                              ),
                                             )
                                           ),
                                      Flexible(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(value.categorytext[val],style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 13),),
                                      )),
                                  
                                                               
                                        ],
                                      ),
                                                              );
                                                            } )
                                                          ),
                                                        ),
                                                      );
                                    }
                                  ),
                                );
  }
}