import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_app/views/home_screen.dart';
import 'package:fyp_app/views/tables_details.dart';
import 'package:fyp_app/views/viewallfood.dart';

import '../views/for_admin/add_discount.dart';
import '../views/profile_screen.dart';

class BottomBar extends StatefulWidget {

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {



  @override
  Widget build(BuildContext context) {
    return  CurvedNavigationBar(
    backgroundColor: Colors.yellow,
    items: <Widget>[
      Icon(Icons.add, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.compare_arrows, size: 30),
    ],
    onTap: (index){},
  );
  }
}


class OldBottomBar extends StatefulWidget {

  
  const OldBottomBar({Key? key}) : super(key: key);

  @override
  _OldBottomBarState createState() => _OldBottomBarState();
}

class _OldBottomBarState extends State<OldBottomBar> {
 

  @override
  void initState() {
    super.initState();

   
  }



  @override
  Widget build(BuildContext context) {
    
    return BottomAppBar(
      color:   Color(0xfff262434),
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.all(8),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,

                   size: 30,
              ),
              onPressed: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.table_bar,
                color: Colors.white,
                   size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TablesDetailScreen()));
              },
            ),
            //3
            // IconButton(
            //   icon: Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //        size: 30,
            //   ),
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => HomeScreen()));
            //   },
            // ),

            //4
            IconButton(
              icon: Icon(
                FontAwesomeIcons.percent,
                color: Colors.white,
                   size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddDiscount()));
              },
            ),
//5
                 IconButton(
              icon: Icon(
               Icons.person,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            )
      
          ],
        ),
      ),
    
    );
  }
}
