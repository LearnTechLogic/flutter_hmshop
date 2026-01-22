// 每一个轮播图的具体类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    // 必须返回BannerItem对象
    return BannerItem(id: json['id'], imgUrl: json['imgUrl']);
  }
}

// 分类列表
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({required this.id, required this.name, required this.picture, this.children});
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    // 必须返回BannerItem对象
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      children: json['children'] == null ? null : (json['children'] as List).map((e) => CategoryItem.fromJson(e)).toList(),
    );
  }
}

//特惠推荐
class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommendResult.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json['id'],
      title: json['title'],
      subTypes: (json['subTypes'] as List)
          .map((item) => SubType.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'],
      title: json['title'],
      goodsItems: GoodsItems.fromJson(json['goodsItems'] as Map<String, dynamic>),
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      page: json['page'],
      items: (json['items'] as List)
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      price: json['price'],
      picture: json['picture'],
      orderNum: json['orderNum'],
    );
  }
}
