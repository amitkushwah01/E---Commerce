import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/cart-model.dart';
import 'package:ecomm/models/cart-price-controller.dart';
import 'package:ecomm/screens/user-panel/check-out-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget
{
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController = Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text('Cart Screen',style: TextStyle(color: AppConstant.appTextColor),),
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
      Container(
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
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
            productPriceController.fetchProductPrice();
            return SwipeActionCell(
              trailingActions: [
                SwipeAction(
                  title: 'Delete',
                  forceAlignmentToBoundary: true,
                  performsFirstActionWithFullSwipe: true,
                  onTap: (CompletionHandler handler)async
                  {
                    print('Delete');
                    await FirebaseFirestore.instance
                    .collection('cart')
                    .doc(user!.uid)
                    .collection('cardOrders')
                    .doc(cartModel.productId)
                    .delete();

                    Fluttertoast.showToast(
                      timeInSecForIosWeb: 2,
                      msg: 'Deleted '
                    );
                  }
                )
              ],
              key: ObjectKey(cartModel.productId),
              child:
              Card(
                elevation: 5,
                color: AppConstant.appTextColor,
                child: ListTile(
                  leading: CircleAvatar(
                    child:Image.network(cartModel.productImages[0]),
                  ),
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cartModel.productName),
                      TextButton.icon(
                        icon: Icon(Icons.arrow_back),
                        label: Text('Swip Delete',style: TextStyle(color: Colors.red),),
                        onPressed: (){},
                      ),
                    ],
                  ),
                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(cartModel.productTotalPrice.toString()),
                      SizedBox(width : Get.width / 20 ),
                      GestureDetector(
                        onTap: () {
                          if(cartModel.productQuantity > 1 )
                          {
                            FirebaseFirestore.instance
                            .collection('cart')
                            .doc(user!.uid)
                            .collection('cardOrders')
                            .doc(cartModel.productId)
                            .update({
                              'productQuantity':cartModel.productQuantity - 1,
                              'productTotalPrice':(double.parse(cartModel.fullPrice)*(cartModel.productQuantity - 1))
                            });
                          }
                        },
//        -------- Minus Button Start
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppConstant.appMainColor,
                          child: Icon(Icons.remove,size: 18,color: AppConstant.appTextColor,)
                        ),
                      ),
                      SizedBox(width : Get.width / 20 ),
                      InkWell(
                          onTap: () async{
                            if(cartModel.productQuantity > 0 )
                            {
                              await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cardOrders')
                              .doc(cartModel.productId)
                              .update({
                                'productQuantity':cartModel.productQuantity + 1,
                                'productTotalPrice':
                                    double.parse(cartModel.fullPrice) +
                                        double.parse(cartModel.fullPrice) * 
                                            (cartModel.productQuantity)
                              });
                            }
                          },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppConstant.appMainColor,
                          child: Icon(Icons.add,size: 18,color: AppConstant.appTextColor,)
                        ),
                      ),
                    ],
                  ),
                ),
              )
            );
            // Card(
            //   elevation: 5,
            //   color: AppConstant.appTextColor,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child:Image.network(productModel.productImages[0]),
            //     ),
            //     title: Text(productModel.productName),
            //     subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Text(productModel.productTotalPrice.toString()),
            //         SizedBox(width : Get.width / 20 ),
            //         CircleAvatar(
            //           radius: 14,
            //           backgroundColor: AppConstant.appMainColor,
            //           child: Icon(Icons.add,size: 18,)
            //         ),
            //         SizedBox(width : Get.width / 20 ),
            //         CircleAvatar(
            //           radius: 14,
            //           backgroundColor: AppConstant.appMainColor,
            //           child: Icon(Icons.remove,size: 18,)
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          },
        )
      );
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: 5),
      //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text('Total'),
      //       Text('INR 1200/-' , style: TextStyle(fontWeight: FontWeight.bold),),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Material(
      //           child: Container(
      //             width: Get.width / 2.0,
      //             height: Get.height / 18,
      //             decoration: BoxDecoration(
      //               color: AppConstant.appSecondoryColor,
      //               borderRadius: BorderRadius.circular(20)
      //             ),
      //             child: TextButton(
      //               onPressed: (){},
      //               child:Text(
      //                 'Check Out',
      //                 style: TextStyle(
      //                   color: AppConstant.appTextColor
      //                 ),
      //               ),
      //               onLongPress: (){},
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
                  // GridView.builder(
                  //   itemCount: snapshot.data!.docs.length,
                  //   shrinkWrap: true,
                  //   physics: BouncingScrollPhysics(),
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     mainAxisSpacing: 3,
                  //     crossAxisSpacing: 5,
                  //     childAspectRatio: 0.80
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     final productData = snapshot.data!.docs[index];
                  //     CartModel productModel = CartModel(
                  //       productId: productData['productId'],
                  //       categoriesId: productData['categoriesId'],
                  //       productName: productData['productName'],
                  //       categoriesName: productData['categoriesName'],
                  //       salePrice: productData['salePrice'],
                  //       fullPrice: productData['fullPrice'],
                  //       productImages: productData['productImages'],
                  //       deliveryTime: productData['deliveryTime'],
                  //       isSale: productData['isSale'],
                  //       productDescription: productData['productDescription'],
                  //       createAt: productData['createAt'],
                  //       updateAt: productData['updateAt'],
                  //       productQuantity:productData['productQuantity'],
                  //       productTotalPrice: productData['productTotalPrice'],
                  //     );
                  //     // CategoriesModel categoriesModel = CategoriesModel(
                  //     //   categoriesId: snapshot.data!.docs[index]['categoriesId'],
                  //     //   categoriesImg: snapshot.data!.docs[index]['categoriesImg'],
                  //     //   categoriesName: snapshot.data!.docs[index]['categoriesName'],
                  //     //   createAt: snapshot.data!.docs[index]['createAt'],
                  //     //   updateAt: snapshot.data!.docs[index]['updateAt'],
                  //     // );
                  //     return Row(
                  //       children: [
                  //         InkWell(
                  //           // onTap: ()=>Get.to(ProductDetailScreen(productModel: productModel)),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: FillImageCard(
                  //               borderRadius: 20.0,
                  //               width: Get.width /2.3,
                  //               heightImage: Get.height / 6,
                  //               imageProvider: CachedNetworkImageProvider(productModel.productImages[0] ),
                  //               title: Center(
                  //                 child: Text(
                  //                   productModel.productName,
                  //                   overflow: TextOverflow.ellipsis,
                  //                   maxLines: 1,
                  //                   style: TextStyle(fontSize: 12),
                  //                 )
                  //               ),
                  //               footer: Center(child: Text('INR : '+productModel.fullPrice + '/-')),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     );
                  //   },
                  // );
              }
              {
                return Container();
              }
            }
          ),
        ],
      ),

      // Container(
      //   child: ListView.builder(
      //     itemCount: 20,
      //     shrinkWrap: true,
      //     physics: BouncingScrollPhysics(),
      //     itemBuilder: (context, index) {
      //       return Card(
      //         elevation: 5,
      //         color: AppConstant.appTextColor,
      //         child: ListTile(
      //           leading: CircleAvatar(
      //             backgroundColor: AppConstant.appMainColor,
      //             child: Text('N'),
      //           ),
      //           title: Text('New Dress For  Womens'),
      //           subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Text('2200'),
      //               SizedBox(width : Get.width / 20 ),
      //               CircleAvatar(
      //                 radius: 14,
      //                 backgroundColor: AppConstant.appMainColor,
      //                 child: Text('+'),
      //               ),
      //               SizedBox(width : Get.width / 20 ),
      //               CircleAvatar(
      //                 radius: 14,
      //                 backgroundColor: AppConstant.appMainColor,
      //                 child: Text('-'),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   )
      // ),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: 5),
      //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text('Total'),
      //       Text('INR 1200/-' , style: TextStyle(fontWeight: FontWeight.bold),),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Material(
      //           child: Container(
      //             width: Get.width / 2.0,
      //             height: Get.height / 18,
      //             decoration: BoxDecoration(
      //               color: AppConstant.appSecondoryColor,
      //               borderRadius: BorderRadius.circular(20)
      //             ),
      //             child: TextButton(
      //               onPressed: (){},
      //               child:Text(
      //                 'Check Out',
      //                 style: TextStyle(
      //                   color: AppConstant.appTextColor
      //                 ),
      //               ),
      //               onLongPress: (){},
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),

      // ),
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
                      'Check Out',
                      style: TextStyle(
                        color: AppConstant.appTextColor
                      ),
                    ),
                    onPressed: (){
                      Get.to(()=>CheckOutScreen());
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
}