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

Future<List<CategoryItem>> getCategoryListAPI () async{
  // 获取分类列表
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((item) {
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

Future<SpecialRecommendResult> getProductListAPI () async{
  // 获取商品列表
  return SpecialRecommendResult.fromJson(await dioRequest.get(HttpConstants.PRODUCT_LIST));
}