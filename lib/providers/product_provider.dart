
import 'dart:io';

import 'package:ecomadmin/models/product_model.dart';
import 'package:ecomadmin/models/purchase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/category_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList=[];
  Future<void> addNewCategory(String category) {
    final categoryModel = CategoryModel(categoryName: category);
    return DbHelper.addCategory(categoryModel);
  }

  getAllCategories(){
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList=List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      
      categoryList.sort((cat1,cat2)=> cat1.categoryName.compareTo(cat2.categoryName));
      notifyListeners();
    });
  }

  Future<String> uploadImage(String thumbnailImageLocalPath) async {
    final photoRef = FirebaseStorage.instance
        .ref()
        .child('ProductImages/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask=photoRef.putFile(File(thumbnailImageLocalPath));
    final snapshot= await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();

  }

  Future<void>addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    return DbHelper.addNewProduct(productModel, purchaseModel);
  }
}