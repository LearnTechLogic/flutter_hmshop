
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