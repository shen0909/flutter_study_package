


class DBprovider{

  //单例模式创建SQLite访问
  static final DBprovider _singleton = DBprovider._internal();

  factory DBprovider(){
     return _singleton;
  }

  DBprovider._internal();
  //初始化数据库
}


