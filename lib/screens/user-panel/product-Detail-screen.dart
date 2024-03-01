// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/cart-model.dart';
import 'package:ecomm/models/product-model.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget
{
  ProductModel productModel;
  ProductDetailScreen({required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  User? user = FirebaseAuth.instance.currentUser;

  bool favButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Product Detail',style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: Container(
        child: Column(
          children: [
            // Product Images
            SizedBox(height: Get.height / 80,),
            CarouselSlider(
              items: widget.productModel.productImages
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context,url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator()
                          ),
                        ),
                        errorWidget: (context,url,error)=> Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    aspectRatio: 2.5,
                    viewportFraction: 1,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.productModel.productName),
                            InkWell(
                              onTap: () {
                                favButton = favButton?false:true;
                                setState(() {});
                              },
                              child: favButton
                              ? Icon(Icons.favorite_outline,)
                              : Icon(Icons.favorite,color: Colors.red,)
                            ),
                          ],
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.productModel.isSale == true && widget.productModel.salePrice!=''?
                            Text('INR : '+widget.productModel.salePrice + '/-')
                            :
                            Text('INR : '+widget.productModel.fullPrice + '/-'),
                          ],
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(widget.productModel.productDescription)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppConstant.appSecondoryColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              width: Get.width / 3,
                              height: Get.height / 16,
                              child: TextButton(
                                onPressed: (){
                                  sendMessegeOnWhatsApp(
                                    productModel:widget.productModel,
                                  );
                                },
                                child:Text(
                                  'WhatsApp',
                                  style: TextStyle(
                                    color: AppConstant.appTextColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width /20,),
                          Material(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppConstant.appSecondoryColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              width: Get.width / 3,
                              height: Get.height / 16,
                              child: TextButton(
                                onPressed: (){
                                  checkProductExit(uId: user!.uid);
                                  Fluttertoast.showToast(
                                    timeInSecForIosWeb: 2,
                                    msg: 'Added to Cart Succesfully'
                                  );
                                },
                                child:Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: AppConstant.appTextColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<void> sendMessegeOnWhatsApp({
    required ProductModel productModel
  })async
  {
    final number = '+919808120806';

    final messege = 
'Hello Amit Kushwah \n I want to know about this product \n ${productModel.productName} \n ${productModel.productId}';
    
    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(messege)}';

    // ignore: deprecated_member_use
    if(await canLaunch(url))
    {
      // ignore: deprecated_member_use
      await launch(url);
    }
    else
    {
      throw 'Could not launch $url';
    }
  }

  Future<void> checkProductExit({
    required String uId , int quantityIncrement = 1
  })async
  {
    final DocumentReference documentReference = FirebaseFirestore.instance
    .collection('cart')
    .doc(uId)
    .collection('cardOrders')
    .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if(snapshot.exists)
    {
      int currentQuantity = snapshot['productQuantity'];
      int updateQuantity = currentQuantity+quantityIncrement;

      double totalPrice = double.parse(
        widget.productModel.isSale
        ? widget.productModel.salePrice
        : widget.productModel.fullPrice
      )*updateQuantity;

      await documentReference.update({
        'productQuantity':updateQuantity,
        'productTotalPrice':totalPrice,
      });
      print('Product Exits');
    }
    else
    {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
        {
          'uId':uId,
          'createAt':DateTime.now(),
        }
      );
      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoriesId: widget.productModel.categoriesId,
        productName: widget.productModel.productName,
        categoriesName: widget.productModel.categoriesName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createAt: widget.productModel.createAt, 
        updateAt: widget.productModel.updateAt,
        productQuantity: 1,
        productTotalPrice: double.parse(
          widget.productModel.isSale
          ? widget.productModel.salePrice
          : widget.productModel.fullPrice
        ),
      );
      await documentReference.set(cartModel.toMap());
      print('Product Added');
    }
  }
}