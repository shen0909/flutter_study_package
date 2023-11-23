//使用单例模式，封装一个网络工具类
import 'package:dio/dio.dart';

import 'dio_log_interceptor.dart';

class HttpManager {
  //1、通过静态方法 getInstance() 访问实例—————— getInstance() 构造、获取、返回实例
  /*通过工厂方法获取该类的实例，将实例对象按对应的方法返回出去
   *实例不存在时，调用命名构造方法获取一个新的实例 */
  static HttpManager getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance!;
  }

  //2、静态属性——该类的实例
  static HttpManager? _instance = HttpManager._internal();

  // 3、私有的命名构造函数，确保外部不能拿到它————初始化实例
  /*在私有构造方法中，在里面可以进行初始化dio实例*/
  HttpManager._internal() {
    //4.2、设置BaseOptions
    BaseOptions baseOptions = BaseOptions(
      //基本网址
      baseUrl: "https://lionstock-uat-new.chinaeast2.cloudapp.chinacloudapi.cn:8200/",
      //连接超时
      connectTimeout: Duration(milliseconds: 30000),
      //接收超时
      receiveTimeout: Duration(milliseconds: 5000),
      //包头/请求头
      headers: {
        "Content-Type": "application/json;Charset=UTF-8",
        "connect": "get"
      },
      //内容类型
      contentType: 'application/json;Charset=UTF-8',
      //响应类型——期待已那种方式接收数据，默认是json
      responseType: ResponseType.json,
    );
    //4.3 初始化dio实例
    dio = new Dio(baseOptions);
    //添加一个自定义拦截器
    dio.interceptors.add(new DioLogInterceptor());
  }

  // 4.1、创建一个 Dio 实例
  late Dio dio;

  // get请求封装
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
  get(String url, {option, params, data}) async {
    Response response;
    try {
      response = await dio.get(url,
          options: option, queryParameters: params, data: data);
      //响应体
      print("response.data:${response.data}");
      //响应的状态码
      print("response.statusCode:${response.statusCode}");
      //对应状态码的详情信息
      print("response.statusMessage:${response.statusMessage}\n");
      //响应头
      print("response.headers:${response.headers}");
      //请求的实际配置
      print("response.requestOptions:${response.requestOptions}");
      //返回响应的数据
      return response.data;
    } on DioException catch (e) {
      print(e.requestOptions);
      print(e.message);
    }
  }

  // post请求封装
  /*Dio的post方法更像是dio.get()。其他一切保持不变，但我们需要提供标头信息和数据以发送到服务器。
   * 大多数 post 方法需要发送特殊类型的令牌才能发送到服务器。我们将在标头中发送该信息。
   * 首先让我们研究从本地设备查找令牌然后返回该 header 的方法。我们将在dio.post()方法中使用返回的标头。*/
  post(api, {params}) async {
    Response response;
    //请求参数 为空时，配置
    if (params == null) {
      params = Map<String, dynamic>();
      params["marketNo"] = "PC_Flutter";
      params["versionNo"] = '10105'; /*版本号*/
      params["token"] = '6b2fc908787c428ab16559fce9d86bf2';
      params["uid"] = '201323';
    }

    //FinanceAppAPI/trade/queryRate  获取汇率接口
    //FinanceAppAPI/user/queryLoginTradeAccount 用户信息接口
    //FinanceAppAPI/trade/queryMarkets   股票市场接口
    try {
      response = await dio.post(api, queryParameters: params,
          onSendProgress: (int sent, int total) {
        print("监听发送（上传）数据进度:${sent} ${total}");
      });
      print("post response:${response.data}\n");
    } on DioException catch (e) {
      print("post出错:${e.toString()}");
    }
  }

  //上传图片操作封装
  uploadImage(url, filePath, {option}) async {
    Response response;

    final formdata = FormData.fromMap({
      'file': await MultipartFile.fromFile(
          filePath,
          filename: DateTime.now().millisecondsSinceEpoch.toString() + '.jpg'),
    });
    try {
      response = await dio.post(url, options: option, data: formdata,onSendProgress: (int send,int total){
        print("进度：${100-total~/send}%");
      });
      return response.data;
    } on DioException catch (e) {
      print("上传图片出错:${e.message}");
    }
  }

  // 上传pdf文件操作封装
  uploadPdf(url,filePath,fileName,{option}) async {

    Response response ;
    FormData formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            filePath,
            filename: fileName),
        }
    );
    try {
      response = await dio.post(url, options: option, data: formData,onSendProgress: (int send,int total){
        double progressPercent = send / total * 100;
        print("进度：$progressPercent%");
      });
      return response.data;
    } on DioException catch (e) {
      print("上传pdf出错:${e.message}");
    }
  }
}
