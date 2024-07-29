import 'dart:developer';

import 'package:abramo_coffee/models/cart_model.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartProvider {
  CartProvider._privateConstructor();
  static final CartProvider instance = CartProvider._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, sqfliteDatabaseName);
    log('Database initiated');
    return await openDatabase(path,
        version: sqfliteDatabaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable (
        $cartColumnId INTEGER PRIMARY KEY,        
        $cartColumnName TEXT NOT NULL,
        $cartColumnQuantity INTEGER NOT NULL,
        $cartColumnPrice REAL NOT NULL,
        $cartColumnImage TEXT NOT NULL,
        $cartColumSubtotalPerItem REAL NOT NULL
      )
    ''');
  }

  Future<int> insert(CartModel cartModel) async {
    final db = await database;
    log("""
Cart Model = $cartModel
Cart Model Id = ${cartModel.id}
Cart Model Name = ${cartModel.name}
Cart Model Quantity = ${cartModel.quantity}
Cart Model Price = ${cartModel.price}
Cart Model Image = ${cartModel.image}
Cart Model Sub Total = ${cartModel.subTotalPerItem}
""");
    log("${cartModel.toMap()}");
    return await db.insert(cartTable, cartModel.toMap());
  }

  Future<List<CartModel>> query() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(cartTable);
    return List.generate(maps.length, (i) {
      return CartModel(
          id: maps[i][cartColumnId],
          name: maps[i][cartColumnName],
          quantity: maps[i][cartColumnQuantity],
          price: maps[i][cartColumnPrice].round(),
          image: maps[i][cartColumnImage],
          subTotalPerItem: maps[i][cartColumSubtotalPerItem].round());
    });
  }

  Future<int> update(CartModel cartModel) async {
    final db = await database;
    return await db.update(cartTable, cartModel.toMap(),
        where: '$cartColumnId = ?', whereArgs: [cartModel.id]);
  }

  Future<double> getItemSubtotal() async {
    final db = await database;
    final data = await db
        .rawQuery("SELECT SUM($cartColumSubtotalPerItem) FROM $cartTable");
    var subtotal = data[0]["SUM($cartColumSubtotalPerItem)"].toString();
    log("subtotal : $subtotal");
    if (subtotal == "0") {
      return 0.0;
    } else {
      return double.parse(subtotal);
    }
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db
        .delete(cartTable, where: '$cartColumnId = ?', whereArgs: [id]);
  }

  Future deleteAllData() async {
    final db = await instance.database;

    db.execute("delete from $cartTable");
    db.execute("vacuum");
  }
}
