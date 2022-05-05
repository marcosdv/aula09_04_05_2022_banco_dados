import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:sqflite/sqflite.dart';

class EditoraHelper {
  static const createSql = '''
    CREATE TABLE IF NOT EXISTS ${Editora.Tabela} (
      ${Editora.campoCodigo} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Editora.campoNome} TEXT
    )
  ''';

  Future<Editora> inserir(Editora editora) async {
    Database db = await BancoDados().db;
    editora.codigo = await db.insert(Editora.Tabela, editora.toMap());

    db.close();
    return editora;
  }

  Future<int> alterar(Editora editora) async {
    Database db = await BancoDados().db;

    int retorno = await db.update(Editora.Tabela, editora.toMap(),
      where: '${Editora.campoCodigo} = ?',
      whereArgs: [editora.codigo]
    );

    db.close();
    return retorno;
  }

  Future<int> apagar(Editora editora) async {
    Database db = await BancoDados().db;

    int retorno = await db.delete(Editora.Tabela,
      where: '${Editora.campoCodigo} = ?',
      whereArgs: [editora.codigo]
    );
    db.close();

    return retorno;
  }
}