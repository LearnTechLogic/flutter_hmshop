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

// 热榜推荐
Future<SpecialRecommendResult> getInVogueListAPI() async {
  return SpecialRecommendResult.fromJson(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialRecommendResult> getOneStopListAPI() async {
  return SpecialRecommendResult.fromJson(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
    Map<String, dynamic> params,
    ) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
  as List)
      .map((item) {
    return GoodDetailItem.formJSON(item as Map<String, dynamic>);
  })
      .toList();
}

