import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/product-model.dart';
import 'package:ecomm/screens/user-panel/cart-screen.dart';
import 'package:ecomm/screens/user-panel/product-Detail-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class AllProductScreen extends StatefulWidget
{
  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text('All Product',style: TextStyle(color: AppConstant.appTextColor),),
        actions: [
          InkWell(
            onTap: () => Get.to(CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body:
      FutureBuilder(
        future : FirebaseFirestore.instance.collection('products')
        .where('isSale',isEqualTo: false)
        .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot )
        {
          if(snapshot.hasError)
          {
            return Center(child: Text('Error'));
          }
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator()
              ),
            );
          }
          if(snapshot.data!.docs.isEmpty)
          {
            return Center(
              child: Text('No Products Found'),
            );
          }
          if(snapshot.data!=null)
          {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.80
                ),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  ProductModel productModel = ProductModel(
                    productId: productData['productId'],
                    categoriesId: productData['categoriesId'],
                    productName: productData['productName'],
                    categoriesName: productData['categoriesName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createAt: productData['createAt'],
                    updateAt: productData['updateAt'],
                  );
                  // CategoriesModel categoriesModel = CategoriesModel(
                  //   categoriesId: snapshot.data!.docs[index]['categoriesId'],
                  //   categoriesImg: snapshot.data!.docs[index]['categoriesImg'],
                  //   categoriesName: snapshot.data!.docs[index]['categoriesName'],
                  //   createAt: snapshot.data!.docs[index]['createAt'],
                  //   updateAt: snapshot.data!.docs[index]['updateAt'],
                  // );
                  return Row(
                    children: [
                      InkWell(
                        onTap: ()=>Get.to(ProductDetailScreen(productModel: productModel)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width /2.3,
                            heightImage: Get.height / 6,
                            imageProvider: CachedNetworkImageProvider(productModel.productImages[0] ),
                            title: Center(
                              child: Text(
                                productModel.productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                              )
                            ),
                            footer: Center(child: Text('INR : '+productModel.fullPrice + '/-')),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
          }
          {
            return Container();
          }
        }
      ),
    );
  }
}