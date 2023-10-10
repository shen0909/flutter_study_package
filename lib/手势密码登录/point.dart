// 圆点属性
class Point {
  double x; // x坐标
  double y; // y坐标
  bool isSelect = false; // 是否被选择 -默认未被选择
  int position; // 索引

  Point({
    required this.x,
    required this.y,
    required this.position
  });
}