class ProductModel
{
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
  ProductModel({
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
  });
  Map<String , dynamic> toMap()
  {
    return {
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
    };
  }
  factory ProductModel.fromMap(Map<String , dynamic>json)
  {
    return ProductModel(
      productId: json['productId'],
      categoriesId: json['categoriesId'],
      productName: json['productName'],
      categoriesName: json['categoriesName'],
      salePrice: json['salePrice'],
      fullPrice: json['fullPrice'],
      productImages: json['productImages'],
      deliveryTime: json['deliveryTime'],
      isSale: json['isSale'],
      productDescription: json['productDescription'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
    );
  }
}