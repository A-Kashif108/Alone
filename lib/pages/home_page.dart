import 'package:flutter/material.dart';
import 'package:mdg_project/components/navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h =MediaQuery.of(context).size.height;
    double w =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFcffaff),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title:  const Text(
          "Alone",
          style: TextStyle(color: Colors.blue,fontSize: 22),

        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,

          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
                height: h*0.15,
                width: w*0.9,
                color: const Color(0xFF7adae6),
                child: Row(
                  children:  const [

                  ],
                ),
              ),
             Container(
               height: h*0.15,
               width: w*0.9,
               color: Colors.blueAccent,
             ),
          ],
        ),
      ),
      drawer: const Drawer(),
      bottomNavigationBar: const NaviBar(),

    );
  }


}
