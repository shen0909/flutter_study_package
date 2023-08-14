import 'package:flutterapp/10%20getx/pages/page_one.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../pages/page_two.dart';

class bind1 implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<pageOneController>(pageOneController());
    // Get.put<pageTwoController>(pageTwoController());
    Get.lazyPut<pageTwoController>(() => pageTwoController());
    // Get.lazyput<pageTwoController>(pageTwoController());
  }

}