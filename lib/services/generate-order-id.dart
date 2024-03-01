import 'dart:math';

String generateOrderId()
{
  DateTime now = DateTime.now();

  int randumNumbers = Random().nextInt(9999);
  String id = '${now.microsecondsSinceEpoch}_$randumNumbers';

  return id;
}