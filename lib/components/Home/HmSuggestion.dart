//推荐
import 'package:flutter/material.dart';
import 'package:flutter_hmshop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  const HmSuggestion({Key? key, required this.specialRecommendResult})
    : super(key: key);

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 取前3条数据
  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  // 构建头部
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(color: const Color.fromARGB(255, 124, 63, 58)),
        ),
      ],
    );
  }

  // 构建左部结构
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length, (int index) {
      return Expanded(
        child: Column(
          children: [
            // ClipRRect 可以包裹子元素 裁剪图片设置圆角
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  // 返回一个新的部件替换原有图片
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    // width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                  );
                },
                list[index].picture,
                // width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 76, 54),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "￥${list[index].price}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  // 完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
