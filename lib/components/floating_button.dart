import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdg_project/builder/assignment_builder.dart';
import '../utils/routes.dart';
class FloatButton extends StatefulWidget {

   const FloatButton({Key? key}) : super(key: key);

  @override
  State<FloatButton> createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> {
  @override
  Widget build(BuildContext context) {
    return  Visibility(
                  visible: true,
                  child: FloatingActionButton(
                      child: const Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blueAccent.shade200,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>const Assignment_Builder(),),

                        );
                      }
                  ),
                );


  }
}
