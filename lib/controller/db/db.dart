import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  late Database db;

  // Initialize the database
  Future<void> initDataBase() async {
    db = await _openDatabase();
    await insertProducts(); // Add this line to insert products when initializing.
  }

  // Open the database or create a new one
  Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, image TEXT, rate TEXT)',
        );
      },
    );
  }

  // Function to insert products into the database
  Future<void> insertProducts() async {
    for (var product in products) {
      final existingProducts = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [product['id']],
      );

      if (existingProducts.isEmpty) {
        await db.insert('products', product);
      }
    }
  }

  Future<List<Map<String, dynamic>>?> getProductsForCode(String code) async {
    final productsList = <Map<String, dynamic>>[];
    final codeDigits = code.split('').map(int.parse).toList();

    for (var digit in codeDigits) {
      final products = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [digit],
      );

      if (products.isNotEmpty) {
        productsList.addAll(products);
      }
    }

    return productsList.isNotEmpty ? productsList : null;
  }


//List of products
  List<Map<String, dynamic>> products = [
    {'id': 1, 'name': 'NIKE', 'image': 'assets/nikedp.jpeg', 'rate': '100'},
    {
      'id': 2,
      'name': 'Nike Canvas',
      'image': 'assets/nikedp2.webp',
      'rate': '200'
    },
    {
      'id': 3,
      'name': 'Nike Air',
      'image': 'assets/nikedp3.webp',
      'rate': '300'
    },
    {
      'id': 4,
      'name': 'Nike Air Jordan',
      'image': 'assets/nikedp5.webp',
      'rate': '400'
    },
  ];
}
