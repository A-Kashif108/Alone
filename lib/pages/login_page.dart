
import 'package:flutter/material.dart';
import 'package:mdg_project/utils/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  Material(
      color: Colors.blue[100],
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
            child: Column(
              children:  [
                SizedBox(
                  width: w*0.85,
                  height: h*0.04,
                ),
                const Text(
                    "Welcome",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                ),
                SizedBox(
                  width: w*0.85,
                  height: h*0.07,
                ),
                TextFormField(
                  cursorColor: Colors.cyan,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.book,color: Colors.lightBlueAccent,),
                    labelStyle: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                    labelText: "Enrollment Number"
                  ),
                  keyboardType: TextInputType.number,
                  
                ),
                SizedBox(
                  width: w*0.85,
                  height: h*0.07,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Phone Number cannot be empty";
                    }else if(value.length<10){
                      return "Invalid Phone Number";
                    }

                    return null;
                  },

                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    fillColor: Colors.blueAccent,
                    prefixIcon: Icon(Icons.dialer_sip,color: Colors.lightBlueAccent,),
                    labelStyle: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                    labelText: "Phone"
                  ),
                ),
                SizedBox(
                  width: w*0.85,
                  height: h*0.07,
                ),
                ElevatedButton(

                    style:   ButtonStyle(

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                          ),
                      ),

                      backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, MyRoutes.otpPage);
                    },
                    child:  const Text(
                        "Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),

                    )
                ),

              ],
            ),
          ),
          decoration:  BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 20.0,
                offset: Offset(10.0, 14.0),
              ),
            ],
            borderRadius: BorderRadius.circular(25),
          ),
          height: h*0.65,
          width:  w*0.85,
          // color: Colors.teal,
        ),
      ),
    );
  }
}
