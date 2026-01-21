//分类
import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  const HmCategory({super.key});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // return ListView();
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,// 设置滚动方向
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 80,
          height: 100,
          color: Colors.blue,
          child: Text("分类$index", style: TextStyle(color: Colors.white),),
        );
      }),
    );
  }
}
