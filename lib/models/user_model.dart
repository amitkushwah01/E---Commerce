class UserModel{
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userimg;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final String street;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;
  final String city;

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userimg,
    required this.userDeviceToken,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
    required this.city,
  });
  Map<String , dynamic> toMap()
  {
    return {
      'uId':uId,
      'username':username,
      'email':email,
      'phone':phone,
      'userimg':userimg,
      'userDeviceToken':userDeviceToken,
      'country':country,
      'userAddress':userAddress,
      'street':street,
      'isAdmin':isAdmin,
      'isActive':isActive,
      'createdOn':createdOn,
      'city':city,
    };
  }

  factory UserModel.fromMap(Map<String , dynamic> json)
  {
    return UserModel(
      uId: json['uId'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      userimg: json['userImg'],
      userDeviceToken: json['userDeviceToken'],
      country: json['country'],
      userAddress: json['userAddress'],
      street: json['street'],
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      createdOn: json['createdOn'],
      city:json['city'],
    );
  }
}