import 'package:ecomm/screens/user-panel/all-categories-screen.dart';
import 'package:ecomm/screens/user-panel/all-flash-sale-product.dart';
import 'package:ecomm/screens/user-panel/all-product-screen.dart';
import 'package:ecomm/screens/user-panel/cart-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:ecomm/widgets/AllProduct-widget.dart';
import 'package:ecomm/widgets/bannerWidget.dart';
import 'package:ecomm/widgets/categories-widget.dart';
import 'package:ecomm/widgets/custome-drawer-widget.dart';
import 'package:ecomm/widgets/flash-sale-widget.dart';
import 'package:ecomm/widgets/heading-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondoryColor,
          statusBarBrightness: Brightness.light
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName,style: TextStyle(color:AppConstant.appTextColor),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Get.height /99.0 ,),
            // Banners
            BannerWidget(),
            // Heading
            HeadingWidget(
              headingTitle: 'Categories', 
              headingSubTitle: 'Accordin to your Budget',
              ontapp: ()=>Get.to(AllCategoriesScreen()),
              buttonText: 'See more',
            ),
            //  Categories
            CategoriesWidget(),
            // Heading
            HeadingWidget(
              headingTitle: 'Flash Sale', 
              headingSubTitle: 'Accordin to your Budget',
              ontapp: ()=>Get.to(AllFlashSaleProductScreen()),
              buttonText: 'See more',
            ),

            //  Flash Sale Widget
            FlashSaleWidget(),

            // All Products
            HeadingWidget(
              headingTitle: 'All Product', 
              headingSubTitle: 'Accordin to your Budget',
              ontapp: ()=>Get.to(AllProductScreen()),
              buttonText: 'See more',
            ),

            // All Products
            AllProductWidget()
          ],
        ),
      )
    );
  }
}