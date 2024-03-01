import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/order-model.dart';
import 'package:ecomm/screens/user-panel/main-screen.dart';
import 'package:ecomm/services/generate-order-id.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken,
})async{
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: 'Please Wait');
  if(user!=null)
  {
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cardOrders')
          .get();

          List<QueryDocumentSnapshot> documents = querySnapshot.docs;

          for(var doc in documents){
            Map < String , dynamic > ? data = doc.data() as Map<String , dynamic>;
            String orderId = generateOrderId();

            OrderModel orderModel = OrderModel(
              productId: data['productId'],
              categoriesId: data['categoriesId'],
              productName: data['productName'],
              categoriesName: data['categoriesName'],
              salePrice: data['salePrice'],
              fullPrice: data['fullPrice'],
              productImages: data['productImages'],
              deliveryTime: data['deliveryTime'],
              isSale: data['isSale'],
              productDescription: data['productDescription'],
              createAt: DateTime.now(),
              updateAt: data['updateAt'],
              productQuantity:data['productQuantity'],
              productTotalPrice: double.parse(data['productTotalPrice'].toString(),),
              customerId: user.uid,
              status: false,
              customerName: customerName,
              customerPhone: customerPhone,
              customerAdress: customerAddress,
              customerDeviceToken: customerDeviceToken,
            );

            for(var x=0; x<documents.length; x++)
            {
              await FirebaseFirestore.instance
                  .collection('orders')
                  .doc(user.uid)
                  .set({
                    'uId':user.uid,
                    'customerName':customerName,
                    'customerPhone':customerPhone,
                    'customerAddress':customerAddress,
                    'customerDeviceToken':customerDeviceToken,
                    'orderStatus':false,
                    'createAt': DateTime.now()
                  });
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .doc(user.uid)
                      .collection('confirmOrders')
                      .doc(orderId)
                      .set(orderModel.toMap());

                  await FirebaseFirestore.instance
                      .collection('cart')
                      .doc(user.uid)
                      .collection('cardOrders')
                      .doc(orderModel.productId.toString())
                      .delete()
                      .then((value){
                    print('Delete Cart Product $orderModel.productId.toString()');
                  });
            }
          }
          print('Order Confirmed');
          Get.snackbar(
            'Order Confirm',
            'Thank You for Your Order!',
            backgroundColor: AppConstant.appMainColor,
            colorText: AppConstant.appTextColor,
            duration: Duration(seconds: 5)
          );
          EasyLoading.dismiss();
          Get.offAll(()=>MainScreen());
    }
    catch(e)
    {
      EasyLoading.dismiss();
      print('Error $e');
          Get.snackbar(
            '$e',
            'Thank You for Your Order!',
            backgroundColor: AppConstant.appMainColor,
            colorText: AppConstant.appTextColor,
            duration: Duration(seconds: 5)
          );
    }
  }
}