// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String? name;
  String? discount;
  String? image;
  String? address;
  String? timing;
  List<dynamic>? data;

  CategoryModel({
    this.name,
    this.discount,
    this.image,
    this.address,
    this.timing,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        discount: json["discount"],
        image: json["image"],
        address: json["address"],
        timing: json["timing"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "discount": discount,
        "image": image,
        "address": address,
        "timing": timing,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
