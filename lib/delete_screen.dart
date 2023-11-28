import 'package:backend3/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DeleteProduct extends StatefulWidget {
  const DeleteProduct({super.key});

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  final TextEditingController _productidcontroller = TextEditingController();

  void deleteProduct() async {
    String productid = _productidcontroller.text.trim();

    final formdata = FormData.fromMap({
      "product_id": productid,
    });
    try {
      Response response = await Dio().delete(
          "http://jayanthi10.pythonanywhere.com/api/v1/delete_product/",
          data: formdata);
      print(response.data);

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Productscreen()));
      }
    } catch (e) {
      print("================> Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Delete Products",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFFffffff)),
          ),
          centerTitle: true,
          leading: Icon(
            Icons.arrow_back,
            size: 16,
            color: Color(0xFFffffff),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: _productidcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Product id"),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    deleteProduct();
                  },
                  child: Text("Delete Product"))
            ],
          ),
        ),
      ),
    );
  }
}
