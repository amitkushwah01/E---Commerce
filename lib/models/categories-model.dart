class CategoriesModel
{
  final String categoriesId;
  final String categoriesImg;
  final String categoriesName;
  final dynamic createAt;
  final dynamic updateAt;
  CategoriesModel({
    required this.categoriesId,
    required this.categoriesImg,
    required this.categoriesName,
    required this.createAt,
    required this.updateAt,
  });

  Map<String , dynamic> toMap()
  {
    return {
      'categoriesId'  :categoriesId,
      'categoriesImg' :categoriesImg,
      'categoriesName':categoriesName,
      'createAt'   :createAt,
      'updateAt'    :updateAt
    };
  }
  factory CategoriesModel.fromMap(Map<String , dynamic> json)
  {
    return CategoriesModel(
      categoriesId: json['categoriesId'], 
      categoriesImg: json['categoriesImg'],
      categoriesName: json['categoriesName'],
      createAt: json['createAt'],
      updateAt: json['updateAt']
    );
  }
}