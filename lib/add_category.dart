import 'dart:convert';
import 'dart:io';

import 'package:backend3/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import 'models/products_model.dart';

class Addcategory extends StatefulWidget {
  const Addcategory({super.key});

  @override
  State<Addcategory> createState() => _Addcategorysstate();
}

class _Addcategorysstate extends State<Addcategory> {
  final TextEditingController _categorynamecontroller = TextEditingController();

  void addcategory() async {
    String categoryname = _categorynamecontroller.text.trim();

    final formdata = FormData.fromMap({
      "name": categoryname,
      "image": await MultipartFile.fromFile(image!.path),
    });

    try {
      Response response = await Dio().post(
          "http://jayanthi10.pythonanywhere.com/api/v1/add_category/",
          data: formdata);
      print(response.data);

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Productscreen()));
      }

      print("===========>${response.statusMessage}");

      //products = productsModelFromJson(jsonEncode(response.data));
    } catch (e) {
      print(e);
      print("===========>error}");
    }
  }

  File? image;
  void pickImage(ImageSource source) async {
    try {
      final pickerFile = await ImagePicker().pickImage(source: source);
      setState(() {
        image = File(pickerFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        title: Text(
          "Add categories",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFFffffff)),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Productscreen()));
          },
          child: Icon(
            Icons.arrow_back,
            size: 16,
            color: Color(0xFFffffff),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _categorynamecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Product name"),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => pickImage(ImageSource.gallery),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Select a image",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            image != null
                ? SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        )),
                  )
                : SizedBox(
                    height: 20,
                  ),
            TextButton(
                onPressed: () {
                  addcategory();
                },
                child: Text("Add Category")),
          ],
        ),
      ),
    ));
  }
}
