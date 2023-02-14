import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/dealModel.dart';
import '../providers/find_food_provider.dart';


class TitPage extends StatelessWidget {


final _controller =PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar,
      body: Consumer<FindFood>(
 
        builder: (context, value, child) {
          return PageView(
            
            scrollDirection: Axis.vertical,
            controller: _controller,
            children: List.generate(value.allDeals.length, (index) {
                 DealModel dealModel =
                               value.allDeals[index];
              return 
              dealCard(
                dealModel: dealModel,
      
                        context: context,
                        imgUrl: (dealModel.picture.toString())
                      );
       
            })
            //   categories_card()
            // ],
          );
        }
      ),
    );
  }



   Widget dealCard({
    
    required DealModel dealModel,
    required BuildContext context,
    required String imgUrl,
  }) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
    
        // width: 100,
        decoration: BoxDecoration(
            // border: Border.all(),
            // borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(imgUrl), fit: BoxFit.fill,colorFilter:  ColorFilter.mode(Colors.black, 
      BlendMode.dstATop),)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              Text(
                'Deal1',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white, fontSize: 45),
              ),
                  SizedBox(
                height: 20,
              ),
              Text(
                '${dealModel.item1} + ${dealModel.item2} + ${dealModel.item3} +  ${dealModel.item4} ',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25,fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price 500',
                 
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}