import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:quiz_app/Quiz/test.dart';
import 'package:quiz_app/config/get_it_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(core.get<SharedPreferences>().getString('name')?? ''),),

      body: Stack(
        children: [
          // Background circles
          Positioned(
              top: -25, child: Image(image: AssetImage("assets/first.png"))),
          Positioned(
              left: 40,
              bottom: 450,
              child: Image(image: AssetImage("assets/sec.png"))),
          Positioned(
              bottom: -5,
              right: -5,
              child: Image(image: AssetImage("assets/six.png"))),
          Positioned(
              top: 140,
              left: 30,
              child: Image(image: AssetImage("assets/third.png"))),
          Positioned(
              top: 30,
              left: 250,
              child: Image(image: AssetImage("assets/fourth.png"))),
          Positioned(child: Image(image: AssetImage("assets/fifth.png"))),

          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff914576),
                  ),
                ),
                SizedBox(height: 175),
                Container(
                  width: MediaQuery.sizeOf(context).width * .85,
                  height: 50,
                  child: TextField(
                    controller: name,
                    style: TextStyle(
                        color: Color(0xff914576),
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 15),
                          child: Icon(Icons.email, color: Color(0xff914576))),
                      hintText: 'user@gmail.com',
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      hintStyle: TextStyle(
                          color: Color(0xff914576),
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xff914576),
                          width: 2.0, // Set the border width to 2.0
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xff914576),
                          width: 2.0, // Set the border width to 2.0
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.sizeOf(context).width * .85,
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xff914576),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                        // Adjust the padding as needed
                        child: Icon(
                          Icons.lock,
                          color: Color(0xff914576),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      // Adjust as needed
                      hintStyle: TextStyle(
                        color: Color(0xff914576),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xff914576),
                          width: 2.0, // Set the border width to 2.0
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        // Adjust as needed
                        borderSide: BorderSide(
                          color: Color(0xff914576),
                          width: 2.0, // Set the border width to 2.0
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.sizeOf(context).width * .85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Color(0xffDA8BD9), Color(0xffF3BD6B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      core.get<SharedPreferences>().setString('name', name.text);

                      core.get<SharedPreferences>().setString('pass', password.text);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Quiz(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
