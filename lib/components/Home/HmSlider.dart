//轮播图
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hmshop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  // const HmSlider({super.key});
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  
  Widget _getSlider() {
    // 在fultter中获取屏幕宽度的方法
    final double screenWideth = MediaQuery.of( context).size.width;
    // 返回轮播图插件
    // 根据数据渲染的不同的轮播图选项
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWideth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay:  true,
        autoPlayInterval: Duration(seconds: 3),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索栏 指示灯导航
    return Stack(
      children: [_getSlider()],
    );
    // return Container(
    //   height: 300,
    //   color: Colors.red,
    //   alignment: Alignment.center,
    //   child: Text('轮播图', style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}
