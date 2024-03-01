import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/categories-model.dart';
import 'package:ecomm/screens/user-panel/single-category-productScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoriesWidget extends StatefulWidget
{
  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return 
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
          return Container(
            height: Get.height / 6 , // 5.5
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
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
                      onTap: () => Get.to(AllSingleCategoryProductScreen(categoriesId: categoriesModel.categoriesId)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width /4.0,
                          heightImage: Get.height / 12,
                          imageProvider: CachedNetworkImageProvider(categoriesModel.categoriesImg ),
                          title: Center(child: Text(categoriesModel.categoriesName,style: TextStyle(fontSize: 12),)),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        }
        {
          return Container();
        }
      }
    );
  }
}