import 'package:flutter/material.dart';
import 'package:mdg_project/pages/home_page.dart';
import 'package:mdg_project/utils/routes.dart';
class Enrollment extends StatefulWidget {
  const Enrollment({Key? key}) : super(key: key);

  @override
  State<Enrollment> createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> {
  late String enroll;

  @override
  Widget build(BuildContext context) {
    TextEditingController en = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff1d1d1d),
                  borderRadius: BorderRadius.circular(15),
                ),
                child:  TextFormField(

                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enrollment Number",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 19, horizontal: 8),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                      child: Text(
                        " CSE ",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  onChanged: (v){
                    setState(() {
                      enroll=v;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if(enroll.isEmpty){
                    const SnackBar(content: Text("Enrollment Number is Required"));
                  }else{
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) =>  HomePage(enroll: enroll)),
                            (route) => false);
                  }

                },

                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 280,
                  decoration: BoxDecoration(
                      color: const Color(0xffff9601),
                      borderRadius: BorderRadius.circular(23)),
                  child: const Center(
                    child: Text(
                      "Go",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xfffbe2ae),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
