import 'package:flutter_hmshop/constants/index.dart';
import 'package:flutter_hmshop/utils/DioRequset.dart';
import 'package:flutter_hmshop/viewmodels/home.dart';

Future<GoodsDetailsItems> getGuessListAPI (Map<String, dynamic> params) async {
  return GoodsDetailsItems.fromJson(await dioRequest.get(HttpConstants.GUESS_LIST,  params:  params));
}