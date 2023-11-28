import 'dart:convert';

import 'package:backend3/add_cart.dart';
import 'package:backend3/add_category.dart';
import 'package:backend3/delete_screen.dart';
import 'package:backend3/main.dart';
import 'package:backend3/products_model.dart';
import 'package:backend3/update_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'category_model.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({super.key});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  Productsmodel? products;
  void getproductsdata() async {
    try {
      Response response = await Dio()
          .get("http://jayanthi10.pythonanywhere.com/api/v1/list_products/");
      print(response.data);

      products = productsmodelFromJson(jsonEncode(response.data));
    } catch (e) {
      print("================> Error");
    }
  }

  CategoryModel? category;
  void getcategorydata() async {
    try {
      Response response = await Dio()
          .get("http://jayanthi10.pythonanywhere.com/api/v1/list_category/");
      print(response.data);

      category = categoryModelFromJson(jsonEncode(response.data));
    } catch (e) {
      print("==================>Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproductsdata();
    getcategorydata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.grey.shade400,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products List",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProducts()));
                    },
                    child: Text(
                      "Add Products",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 26,
              ),
              products == null
                  ? CircularProgressIndicator()
                  : Container(
                      height: 200,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              height: 170,
                              width: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 4)
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Image.asset("${products!.data![index].image}"),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "${products!.data![index].image}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${products!.data![index].productName}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF000000)),
                                  ),
                                  Text(
                                    "${products!.data![index].description}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateProduct()));
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DeleteProduct()));
                                        },
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 16,
                            );
                          },
                          itemCount: products!.data!.length),
                    ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Addcategory()));
                    },
                    child: Text(
                      "Add Categories",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              category == null
                  ? CircularProgressIndicator()
                  : Container(
                      height: 300,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "${category!.image}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 26,
                                      ),
                                      Text(
                                        "${category!.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 12,
                            );
                          },
                          itemCount: category!.data!.length))
            ],
          ),
        ),
      ),
    );
  }
}
