import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hmshop/pages/Cart/index.dart';
import 'package:flutter_hmshop/pages/Category/index.dart';
import 'package:flutter_hmshop/pages/Home/index.dart';
import 'package:flutter_hmshop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染四个导航
  // 一般应用程序的导航是固定的
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",// 正常显示的图标
      "active_icon": "lib/assets/ic_public_home_active.png", // 激活显示的图标
      "text": "首页"
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类"
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车"
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的"
    }
  ];
  int _currentIndex = 0;

  // 返回底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget(){
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),// 正常显示图标
        activeIcon: Image.asset(_tabList[index]["active_icon"]!, width: 30, height: 30),// 激活图标
        label: _tabList[index]["text"]
      );
    });
  }

  List<Widget> _getChildren(){
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea避开安全区组件
      body: SafeArea(
        // 堆叠组件
        child: IndexedStack(
          index: _currentIndex,
          children: _getChildren(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels:  true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          // 当前点击的索引
          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),

    );
  }
}
