import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/screens/user-panel/cart-screen.dart';
import 'package:ecomm/screens/user-panel/single-category-productScreen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/categories-model.dart';

class AllCategoriesScreen extends StatefulWidget
{
  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text('All Categories',style: TextStyle(color: AppConstant.appTextColor),),
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
        future : FirebaseFirestore.instance.collection('Categories').get(),
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
              child: Text('No Categories Found'),
            );
          }
          if(snapshot.data!=null)
          {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.19
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                CategoriesModel categoriesModel = CategoriesModel(
                  categoriesId: snapshot.data!.docs[index]['categoriesId'],
                  categoriesImg: snapshot.data!.docs[index]['categoriesImg'],
                  categoriesName: snapshot.data!.docs[index]['categoriesName'],
                  createAt: snapshot.data!.docs[index]['createAt'],
                  updateAt: snapshot.data!.docs[index]['updateAt'],
                );
                return Row(
                  children: [
                    InkWell(
                      onTap: ()=>Get.to(AllSingleCategoryProductScreen(categoriesId: categoriesModel.categoriesId)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width /2.3,
                          heightImage: Get.height / 10,
                          imageProvider: CachedNetworkImageProvider(categoriesModel.categoriesImg ),
                          title: Center(child: Text(categoriesModel.categoriesName,style: TextStyle(fontSize: 12),)),
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