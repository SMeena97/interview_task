import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

extension MediaQuerySize on BuildContext {
  Size getSize() => MediaQuery.of(this).size;
}

extension PercentSized on num {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
  double get sp => this * (Get.width / 3) / 100;
}
