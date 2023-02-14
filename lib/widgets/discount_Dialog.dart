import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:provider/provider.dart';

import '../providers/find_food_provider.dart';

class DiscountDialog extends StatelessWidget {
  final FoodItem foodItem;
  const DiscountDialog({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<FindFood>(
 
   builder: (context, value,child) {
      return Dialog(
      
  
        child:  Container(
                height: width > 800
              ? height / 1.5
              : width > 600
                  ? height / 1.5
                  : height / 4,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
       
            Text('Set Discount',style: Theme.of(context).textTheme.headline3,),
                   
               DropdownButton<String>(
                    // Step 3.
                    value: value.initialvalue,
                    
                    // Step 4.
                    items: value.discount
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                  
                        value.updateInitialDiscountValue(newValue!);
                    },
                  ),
                  // Spacer(),
             
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         TextButton(onPressed: (){}, child: Text('Back',style: Theme.of(context).textTheme.headline3,)),
                        button2(text: 'Ok', press: (){
                          Provider.of<FindFood>(context,listen: false).addDisCount(uid: foodItem.uid.toString(), context: context);
                        }),
                                 
                      ],
                    ),
                  )
                      // ElevatedButton(onPressed: (){},child: Text(''),),
            ],
            
      
          ),
        )
      );
    }
  );
  }
}