class OrderModel
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
  final dynamic updateAt;
  final dynamic createAt;
  final int productQuantity;
  final double productTotalPrice;
  final String customerId;
  final bool status;
  final String customerName;
  final String customerPhone;
  final String customerAdress;
  final String customerDeviceToken;

  OrderModel({
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
    required this.updateAt,
    required this.createAt,
    required this.productQuantity,
    required this.productTotalPrice,
    required this.customerId,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.customerAdress,
    required this.customerDeviceToken,
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
      'updateAt':updateAt,
      'createAt':createAt,
      'productQuantity':productQuantity,
      'productTotalPrice':productTotalPrice,
      'customerId':customerId,
      'status':status,
      'customerName':customerName,
      'customerPhone':customerPhone,
      'customerAdress':customerAdress,
      'customerDeviceToken':customerDeviceToken,
    };
  }
  factory OrderModel.fromMap(Map<String , dynamic>json)
  {
    return OrderModel(
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
      updateAt: json['updateAt'],
      createAt: json['createAt'],
      productQuantity: json['productQuantity'], 
      productTotalPrice: json['productTotalPrice'], 
      customerId: json['customerId'], 
      status: json['status'], 
      customerName: json['customerName'], 
      customerPhone: json['customerPhone'], 
      customerAdress: json['customerAdress'], 
      customerDeviceToken: json['customerDeviceToken']
    );
  }
}