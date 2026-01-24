import 'package:flutter/cupertino.dart';
import 'package:flutter_hmshop/api/home.dart';
import 'package:flutter_hmshop/components/Home/HmCategory.dart';
import 'package:flutter_hmshop/components/Home/HmHot.dart';
import 'package:flutter_hmshop/components/Home/HmMoreList.dart';
import 'package:flutter_hmshop/components/Home/HmSlider.dart';
import 'package:flutter_hmshop/components/Home/HmSuggestion.dart';
import 'package:flutter_hmshop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  // final List<BannerItem> _bannerList = [
  //   BannerItem(id: "1", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
  //   BannerItem(id: "2", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.jpg"),
  //   BannerItem(id: "3", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  // ];
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(id: "", title: "", subTypes: []);
  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(id: "", title: "", subTypes: [],);
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(id: "", title: "", subTypes: [],);
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 获取轮播图数据
  void _getBannerList() async{
     _bannerList = await getBannerListAPI();
     setState(() {});
  }
  // 获取分类数据
  void _getCategoryList() async{
     _categoryList = await getCategoryListAPI();
     setState(() {});
  }
  // 获取推荐数据
  void _getProductList() async{
     _specialRecommendResult = await getProductListAPI();
     setState(() {});
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  // 获取推荐列表
  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }

  // 获取滚动容器的内容
  List<Widget> _getScrollChildern(){
    return [
      // 包裹普通widget的sliver家族的组件
      // 放置轮播图
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      // 放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      // 放置推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion(specialRecommendResult: _specialRecommendResult)),
      // 放置爆款
      SliverToBoxAdapter(child: SizedBox(height:  10)),
      SliverToBoxAdapter(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: HmHot(result: _inVogueResult, type: "hot"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: HmHot(result: _oneStopResult, type: "step"),
            ),

          ],
        )),
      ),
      // 放置无限滚动列表
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }
  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getProductList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern());// 自定义滚动组件，要搭配sliver家族的内容
  }
}
