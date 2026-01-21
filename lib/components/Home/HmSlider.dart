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
  CarouselSliderController _controller = CarouselSliderController();// 控制轮播图跳转的控制器
  int _currentIndex = 0;// 当前轮播图索引
  // 轮播图
  Widget _getSlider() {
    // 在flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of( context).size.width;
    // 返回轮播图插件
    // 根据数据渲染的不同的轮播图选项
    return CarouselSlider(
      carouselController: _controller,// 绑定controller对象
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay:  true,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (int index, reason) {
          _currentIndex = index;
          setState(() {});
        }
      )
    );
  }
  // 搜索栏
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.circular(25)
            ),
            child: Text(
              "搜索...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),
          ),
      )
    );
  }
  // 返回指示灯导航部件
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,// 主轴居中
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(index);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    color: index == _currentIndex ? Colors.white : Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(3)
                ),
              )
            );
          })
        ),
      )
    );
  }

  
  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索栏 指示灯导航
    return Stack(
      children: [_getSlider(), _getSearch(), _getDots()],
    );
    // return Container(
    //   height: 300,
    //   color: Colors.red,
    //   alignment: Alignment.center,
    //   child: Text('轮播图', style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}
