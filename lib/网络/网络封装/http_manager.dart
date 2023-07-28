//使用单例模式，封装一个网络工具类
import 'package:dio/dio.dart';

class HttpManager{

  //1、工厂构造函数——————构造、获取、返回实例
  /*通过工厂方法获取该类的实例，将实例对象按对应的方法返回出去
   *实例不存在时，调用命名构造方法获取一个新的实例 */
  factory HttpManager(){
    if(_instance==null){
      _instance=HttpManager._internal();
    }
    return _instance!;
  }

  //2、静态属性——该类的实例
  static HttpManager? _instance=HttpManager._internal();

  //3、私有的命名构造函数，确保外部不能拿到它————初始化实例
  /*在私有构造方法中，在里面可以进行初始化dio实例*/
  HttpManager._internal(){
    //4.2、设置BaseOptions
    BaseOptions baseOptions=BaseOptions(
      //基本网址
      baseUrl:"https://lionstock-uat-new.chinaeast2.cloudapp.chinacloudapi.cn:8200/",
      //连接超时
      connectTimeout: Duration(milliseconds: 30000),
      //接收超时
      receiveTimeout: Duration(milliseconds: 5000),
      //包头
      headers: {
        "Content-Type": "application/json;Charset=UTF-8",
      },
      //内容类型
      contentType: 'application/json;Charset=UTF-8',
      //响应类型——期待已那种方式接收数据，默认是json
      responseType: ResponseType.json,
    );
    //4.3 初始化dio实例
    dio=new Dio(baseOptions) ;
    dio.interceptors.add(new DioLogInterceptor());
  }

  //4.1、创建一个 Dio 实例
  late Dio dio;

  /*get方法使用指定的路径和查询参数向服务器发送 HTTP GET 请求。
   * 它还允许您传递其他选项，例如标头、响应类型和超时。
   * 该方法返回一个 Future 对象，该对象使用包含来自服务器的 HTTP 响应的 Response 对象进行解析*/
  /*api 参数，表示要请求的API端点
   *params 参数，表示要发送的请求参数
   *withLoading 参数，表示是否显示加载动画
   *options 参数，表示额外的请求选项
   *cancelToken 参数，表示用于取消请求的令牌。 */
  /*BaseOptions 描述的是 Dio 实例发起网络请求的的公共配置，
   *而 Options 描述了每一个Http请求的配置信息，每一次请求都可以单独配置，
   *单次请求的 Options 中的配置信息可以覆盖 BaseOptions 中的配置。*/
  get() async {
    Response response=await dio.get("Customer/openaccount/v1/loadSelectList",);
    print("response.data:${response.data}");
  }
  /*Dio的post方法更像是dio.get()。其他一切保持不变，但我们需要提供标头信息和数据以发送到服务器。
   * 大多数 post 方法需要发送特殊类型的令牌才能发送到服务器。我们将在标头中发送该信息。
   * 首先让我们研究从本地设备查找令牌然后返回该 header 的方法。我们将在dio.post()方法中使用返回的标头。*/
  post() async {
    Response response;
    //请求参数
    Map<String, dynamic> params = Map<String, dynamic>();
    params["marketNo"] = "PC_Flutter";
    params["versionNo"] = '10105';/*版本号*/
    params["token"] = '6b2fc908787c428ab16559fce9d86bf2';
    params["uid"] = '201323';
    //FinanceAppAPI/trade/queryRate  获取汇率接口
    //FinanceAppAPI/user/queryLoginTradeAccount 用户信息接口
    //FinanceAppAPI/trade/queryMarkets   股票市场接口
    response=await dio.post(
        "FinanceAppAPI/trade/queryMarkets",
        queryParameters: params,

    );
    print("post response:${response.data}");
  }
}

//自定义dio拦截器
class DioLogInterceptor extends Interceptor{

  ///请求前
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String requestStr = "\n==================== 请求前拦截——REQUEST ====================\n"
        "- URL:\n${options.baseUrl + options.path}\n"
        "- METHOD: ${options.method}\n";

    requestStr += "- HEADER:\n${options.headers.mapToStructureString()}\n";

    final data = options.data;
    if (data != null) {
      if (data is Map)
        requestStr += "- BODY:\n${data.mapToStructureString()}\n";
      else if (data is FormData) {
        final formDataMap = Map()..addEntries(data.fields)..addEntries(data.files);
        requestStr += "- BODY:\n${formDataMap.mapToStructureString()}\n";
      } else
        requestStr += "- BODY:\n${data.toString()}\n";
    }
    print(requestStr);
    return handler.next(options);
  }

}
///Map拓展，MAp转字符串输出
extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      this.forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr" +
              "\"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          result += "\n$indentationStr" + "\"$key\" : \"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

///List拓展，List转字符串输出
extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "$indentationStr[";
      this.forEach((value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$temp\",";
        } else if (value is List) {
          result += value.listToStructureString(indentation: indentation + 2);
        } else {
          result += "\n$indentationStr" + "\"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += "\n$indentationStr]";
    }

    return result;
  }
}