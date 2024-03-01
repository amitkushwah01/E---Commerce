class CartModel{
  final String productId;
  final String categoriesId;
  final String productName;
  final String categoriesName;
  final String salePrice;
  final String fullPrice;
  final List productImages;
  final String deliveryTime;
  final bool isSale;
  final String productDescription;
  final dynamic createAt;
  final dynamic updateAt;
  final int productQuantity;
  final double productTotalPrice;

  CartModel({
    required this.productId,
    required this.categoriesId,
    required this.productName,
    required this.categoriesName,
    required this.salePrice,
    required this.fullPrice,
    required this.productImages,
    required this.deliveryTime,
    required this.isSale,
    required this.productDescription,
    required this.createAt,
    required this.updateAt,
    required this.productQuantity,
    required this.productTotalPrice,
  });
  
  Map<String , dynamic> toMap()
  {
    return 
    {
      'productId':productId,
      'categoriesId':categoriesId,
      'productName':productName,
      'categoriesName':categoriesName,
      'salePrice':salePrice,
      'fullPrice':fullPrice,
      'productImages':productImages,
      'deliveryTime':deliveryTime,
      'isSale':isSale,
      'productDescription':productDescription,
      'createAt':createAt,
      'updateAt':updateAt,
      'productQuantity':productQuantity,
      'productTotalPrice':productTotalPrice,
    };
  }

}