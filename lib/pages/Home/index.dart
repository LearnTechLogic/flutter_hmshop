import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hmshop/api/home.dart';
import 'package:flutter_hmshop/components/Home/HmCategory.dart';
import 'package:flutter_hmshop/components/Home/HmHot.dart';
import 'package:flutter_hmshop/components/Home/HmMoreList.dart';
import 'package:flutter_hmshop/components/Home/HmSlider.dart';
import 'package:flutter_hmshop/components/Home/HmSuggestion.dart';
import 'package:flutter_hmshop/utils/ToastUtils.dart';
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
  // 页码
  int _page = 1;
  // 是否正在加载
  bool _isLoading = false;
  // 是否有更多数据
  bool _hasMore = true;

  // 获取轮播图数据
  Future<void> _getBannerList() async{
     _bannerList = await getBannerListAPI();
  }
  // 获取分类数据
  Future<void> _getCategoryList() async{
     _categoryList = await getCategoryListAPI();
  }
  // 获取推荐数据
  Future<void> _getProductList() async{
     _specialRecommendResult = await getProductListAPI();
  }
  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }
  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    // 判断是否正在加载数据，或者没有更多数据
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true; // 先站住位置
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; // 放行位置
    setState(() {});
    if (_recommendList.length < requestLimit) {
      // 没有更多数据
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 获取滚动容器的内容
  List<Widget> _getScrollChildren(){
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
    // _getBannerList();
    // _getCategoryList();
    // _getProductList();
    // _getInVogueList();
    // _getOneStopList();
    // _getRecommendList();
    _registerEvent();
    // initState -> build -> 下拉刷新组件 -> 才可以操作它
    // 使用微任务 Future.microtask
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  final ScrollController _controller = ScrollController();
  //  监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent - 50) {
        // 加载下一页数据
        _getRecommendList();
      }
    });
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    // 数据获取成功 刷新成功
    ToastUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  // GlobalKey是一个方法可以创建一个key绑定到Widegt部件上 可以操作Widget部件
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      // onRefresh: () async {
      //   await _onRefresh();
      // },
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          controller: _controller,// 绑定控制器
          slivers: _getScrollChildren()
        )// 自定义滚动组件，要搭配sliver家族的内容
      ),
    );
      

  }
}
