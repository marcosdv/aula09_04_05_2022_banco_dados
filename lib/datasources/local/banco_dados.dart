import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static final BancoDados _instance = BancoDados._internal();
  factory BancoDados() => _instance;
  BancoDados._internal();

  Database? _db;
  Future<Database> get db async {
    _db = await _iniciarDb();
    return _db!;
  }

  Future<Database> _iniciarDb() async {
    const nomeBanco = "meus_livros.db";
    final path = await getDatabasesPath();
    final caminhoBanco = join(path, nomeBanco);

    return await openDatabase(caminhoBanco, version: 1,
      onCreate: (Database db, int newVersion) async {
        await db.execute(EditoraHelper.createSql);
        await db.execute(LivroHelper.createSql);
      }
    );
  }

  void close() async {
    _db?.close();
  }
}