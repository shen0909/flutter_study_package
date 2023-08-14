import 'package:flutterapp/10%20getx/pages/page_one.dart';
import 'package:flutterapp/10%20getx/pages/page_two.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'getx_依赖注入/getx_dependency.dart';

class getRouters{
  static final List<GetPage> getpages=[
    // GetPage(name: '/page_one', page:()=>pageOne(),binding: bind1()),
    GetPage(name: '/page_one', page:()=>pageOne(),),
    GetPage(name: '/page_two', page:()=>pageTwo(),),
    // GetPage(name: '/page_two', page:()=>pageTwo(),binding: bind1()),
  ];

}