import 'package:flutterapp/%E6%95%B0%E6%8D%AE%E5%AD%98%E5%82%A8/%E6%9C%AC%E5%9C%B0%E6%95%B0%E6%8D%AE%E5%BA%93/model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

class DBHelp {
  //私有实例
  static DBHelp? _instance;

  //私有命名构造函数,确保类不能从外部被实例化
  DBHelp._internal();

  //getInstance方法 获取私有实例
  static DBHelp getInstance() {
    if (_instance == null) {
      _instance = DBHelp._internal();
    }
    return _instance!;
  }

  //_db是一个Database类型的成员，用于存储数据库实例
  /*如果数据库存在，则直接返回存在的数据库
   *数据库不存在，则初始化数据库后返回 */
  Database? _db;

  Future<Database> get database async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db!;
  }

  //初始化数据库
  initDB() async {
    print("初始化数据库");
    //1、初始化数据库
    sqfliteFfiInit();
    //2、获取databaseFactoryFfi对象
    var databaseFactory = databaseFactoryFfi;
    print("数据库的地址:${await databaseFactory.getDatabasesPath()}");
    //3、创建数据库
    return await databaseFactory.openDatabase(
        path.join(await databaseFactory.getDatabasesPath(), "text.db"),
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              print("创建数据库");
              return await db.execute("CREATE TABLE textt ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "content TEXT"
                  ")");
            }));
  }

  insertToDB(Model model) async {
    Database db = await database;
    print("insert function called");
    await db.insert("textt", model.toJson());
  }

  Future<List<Model>> queryDate() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query("textt");
    print("查询到的数据：${result}");

    return result.map((item) => Model.fromJson(item)).toList();
    
  }

  deleteData(Model model) async {
    Database db = await database;
    print("delete function called");
    db.delete("textt", where: "id=?", whereArgs: [model.id]);
  }
  
  modify(Model model)async{
    Database db= await database;
    await db.rawUpdate(
      '''
      UPDATE textt
      SET content=?
      WHERE id=?
      ''',
      ["这里是新改的",model.id]
    );
  }
}
