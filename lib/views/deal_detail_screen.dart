


import 'package:flutter/material.dart';
import 'package:fyp_app/providers/find_food_provider.dart';
import 'package:provider/provider.dart';

import '../components/backbtn.dart';
import '../models/dealModel.dart';

class DealsDetailScreen extends StatelessWidget {
  final DealModel dealModel;
  const DealsDetailScreen({super.key, required this.dealModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(leading: BackBtn(),backgroundColor: Theme.of(context).cardColor,),
        body: Consumer<FindFood>(builder: (context, value, child) {
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 100,
                child: Text(
                  'Deals'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  // height:MediaQuery.of(context).size.height-200

                  child: Consumer<FindFood>(builder: (context, vaue, child) {
                    return AnimatedList(
                      initialItemCount:  1,
                      itemBuilder: (context,index,animation){

                      return SlideTransition(position:Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
                      child: dealCard(
                        dealModel: dealModel,
                        context: context,
                        imgUrl: (dealModel.picture.toString()),
                        
                      ),
                      );
                    });
                  }),
                ),
              ),
            ],
          );
        }));
  }

  Widget dealCard({
    required DealModel dealModel,
    required BuildContext context,
    required String imgUrl,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        // width: MediaQuery.of(context).size.width-100,
        // height: MediaQuery.of(context).size.height,
        height:400,
        // width: 100,
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(dealModel.picture.toString()), fit: BoxFit.fill, opacity: 0.8)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                'Deal ${dealModel.dealNo}',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white, fontSize: 35),
              ),
              Text(
                "${dealModel.item1} + ${dealModel.item2} + ${dealModel.item3} + ${dealModel.item4}",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white, fontSize: 17),
              ),
              Text(
                'Price ${dealModel.price}',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ));
  }
}
