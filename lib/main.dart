import 'package:backend3/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: "Flutter Demo Page"));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  void login() async {
    String username = _usernamecontroller.text.trim();
    String password = _passwordcontroller.text.trim();

    final formdata =
        FormData.fromMap({"username": username, "password": password});
    try {
      Response response = await Dio().post(
          "http://jayanthi10.pythonanywhere.com/api/v1/login/",
          data: formdata);
      print(response.data);
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Productscreen()));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Enter Valid username & Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFffffff),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000)),
              ),
              SizedBox(
                height: 32,
              ),
              TextField(
                controller: _usernamecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter Username"),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: _passwordcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter Password"),
              ),
              SizedBox(
                height: 28,
              ),
              InkWell(
                onTap: () {
                  login();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Color(0xFF000000),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFffffff)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
