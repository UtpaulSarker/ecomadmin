import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/models/category_model.dart';
import 'package:ecomadmin/models/product_model.dart';
import 'package:ecomadmin/models/purchase_model.dart';

class DbHelper{
  static final _db=FirebaseFirestore.instance;

  static Future<bool> isAdmin( String uid) async{
    final snapshot=await _db.collection('Admins').doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel) {
    final doc=_db.collection(collectionCategory).doc();
    categoryModel.categoryId=doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Future<void> addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    final wb=_db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    final purchaseDoc = _db.collection(collectionPurchase).doc();
    final categoryDoc = _db.collection(collectionCategory).doc(productModel.category.categoryId);
    productModel.productId=productDoc.id;
    purchaseModel.productId=productDoc.id;
    purchaseModel.purchaseId=purchaseDoc.id;
    wb.set(productDoc, purchaseModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());
    wb.update(categoryDoc, {categoryFieldProductCount: productModel.category.productCount+ purchaseModel.purchaseQuantity});
    return wb.commit();

  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllCategories()=>
  _db.collection(collectionCategory).snapshots();


}