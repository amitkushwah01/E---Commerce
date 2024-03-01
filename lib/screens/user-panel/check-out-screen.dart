import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/controllers/get-customer-device-controller.dart';
import 'package:ecomm/models/cart-model.dart';
import 'package:ecomm/models/cart-price-controller.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../services/place-order-service.dart';

class CheckOutScreen extends StatefulWidget
{
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController = Get.put(ProductPriceController());
  TextEditingController nameController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();
  TextEditingController addressController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text('CheckOut Screen',style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body:

      Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Your Selected Items and Total Amount to pay',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:
                  Obx(() =>
                  Text('${productPriceController.totalPrice}/-' , style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream : FirebaseFirestore.instance
                .collection('cart')
                .doc(user!.uid)
                .collection('cardOrders')
                .snapshots(),
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
                  return 
                  GridView.builder(
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
            CartModel cartModel = CartModel(
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
              productQuantity:productData['productQuantity'],
              productTotalPrice: productData['productTotalPrice'],
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
                            // onTap: ()=>Get.to(ProductDetailScreen(productModel: productModel)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FillImageCard(
                                borderRadius: 20.0,
                                width: Get.width /2.3,
                                heightImage: Get.height / 6,
                                imageProvider: CachedNetworkImageProvider(cartModel.productImages[0] ),
                                title: Center(
                                  child: Text(
                                    cartModel.productName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 12),
                                  )
                                ),
                                footer: Center(child: Text('INR : '+cartModel.fullPrice + '/-')),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
      // Container(
      //   child: ListView.builder(
      //     itemCount: snapshot.data!.docs.length,
      //     shrinkWrap: true,
      //     physics: BouncingScrollPhysics(),
      //     itemBuilder: (context, index) {
      //       final productData = snapshot.data!.docs[index];
      //       CartModel cartModel = CartModel(
      //         productId: productData['productId'],
      //         categoriesId: productData['categoriesId'],
      //         productName: productData['productName'],
      //         categoriesName: productData['categoriesName'],
      //         salePrice: productData['salePrice'],
      //         fullPrice: productData['fullPrice'],
      //         productImages: productData['productImages'],
      //         deliveryTime: productData['deliveryTime'],
      //         isSale: productData['isSale'],
      //         productDescription: productData['productDescription'],
      //         createAt: productData['createAt'],
      //         updateAt: productData['updateAt'],
      //         productQuantity:productData['productQuantity'],
      //         productTotalPrice: productData['productTotalPrice'],
      //       );
      //       productPriceController.fetchProductPrice();
      //       return SwipeActionCell(
      //         trailingActions: [
      //           SwipeAction(
      //             title: 'Delete',
      //             forceAlignmentToBoundary: true,
      //             performsFirstActionWithFullSwipe: true,
      //             onTap: (CompletionHandler handler)async
      //             {
      //               print('Delete');
      //               await FirebaseFirestore.instance
      //               .collection('cart')
      //               .doc(user!.uid)
      //               .collection('cardOrders')
      //               .doc(cartModel.productId)
      //               .delete();
      //             }
      //           )
      //         ],
      //         key: ObjectKey(cartModel.productId),
      //         child:
      //         Card(
      //           elevation: 5,
      //           color: AppConstant.appTextColor,
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               child:Image.network(cartModel.productImages[0]),
      //             ),
      //             title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(cartModel.productName),
      //               ],
      //             ),
      //             subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(cartModel.productTotalPrice.toString()),
      //                 SizedBox(width : Get.width / 20 ),
      //               ],
      //             ),
      //           ),
      //         )
      //       );
      //     },
      //   )
      // );
              }
              {
                return Container();
              }
            }
          ),
        ],
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:EdgeInsets.only(left: MediaQuery.of(context).size.width*.05),
              child: Text('Total Amount'),
            ),
            Obx(() =>
            Text('${productPriceController.totalPrice}/-' , style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondoryColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextButton(
                    child:Text(
                      'Confimr Order',
                      style: TextStyle(
                        color: AppConstant.appTextColor
                      ),
                    ),
                    onPressed: (){
                      showCustomBottomsheet();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showCustomBottomsheet()
  {
    Get.bottomSheet(
      Container(
        height: Get.height*.45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone ',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container( 
                  height: 55.0,
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              ElevatedButton(
                onPressed:()async{
                  // if( nameController.text!='' && phoneController.text!='' && addressController.text!='' )
                  // {
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String address = addressController.text.trim();
                    String customerToken = await getCustomerDeviceToken();
                    placeOrder(
                      context:context,
                      customerName:name,
                      customerPhone:phone,
                      customerAddress:address,
                      customerDeviceToken:customerToken,
                    );
                  // }
                  // else
                  // {
                  //   print('Please fill all detail');
                  // }
                },
                child:Text('Place Order')
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }
}