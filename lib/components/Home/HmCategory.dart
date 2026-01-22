//分类
import 'package:flutter/material.dart';
import 'package:flutter_hmshop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const HmCategory({Key? key, required this.categoryList}) : super(key: key);

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
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final category = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(category.picture),
                Text(category.name, style: TextStyle(color: Colors.black))
              ],
            ),
          );
        }
      ),
    );
  }
}
