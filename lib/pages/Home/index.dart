import 'package:flutter/cupertino.dart';
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
  
  final List<BannerItem> _bannerList = [
    BannerItem(id: "1", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
    BannerItem(id: "2", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.jpg"),
    BannerItem(id: "3", imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  ];
  
  // 获取滚动容器的内容
  List<Widget> _getScrollChildern(){
    return [
      // 包裹普通widget的sliver家族的组件
      // 放置轮播图
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      // 放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: HmCategory()),
      // 放置推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion()),
      // 放置爆款
      SliverToBoxAdapter(child: SizedBox(height:  10)),
      SliverToBoxAdapter(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(child: HmHot()),
            SizedBox(width: 10),
            Expanded(child: HmHot())
          ],
        )),
      ),
      // 放置无限滚动列表
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList()


    ];
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern());// 自定义滚动组件，要搭配sliver家族的内容
  }
}
