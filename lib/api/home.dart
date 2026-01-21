// 封装一个api 目的是返回业务侧要的数据结构
import 'package:flutter_hmshop/constants/index.dart';
import 'package:flutter_hmshop/utils/DioRequset.dart';
import 'package:flutter_hmshop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI () async{
  // 返回请求
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}