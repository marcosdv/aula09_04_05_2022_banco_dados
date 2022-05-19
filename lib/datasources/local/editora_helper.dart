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

  Future<List<Editora>> getTodos() async {
    Database db = await BancoDados().db;

    List listaDados = await db.query(Editora.Tabela);

    return listaDados.map((e) => Editora.fromMap(e)).toList();
    /*
    List<Editora> listaEditora = [];
    for (int i = 0; i < listaDados.length; i++) {
      listaEditora.add(Editora.fromMap(listaDados[i]));
    }
    return listaEditora;
    */
  }

  Future<Editora?> getEditora(int codigo) async {
    Database db = await BancoDados().db;

    List listaDados = await db.query(
      Editora.Tabela,
      columns: [Editora.campoCodigo, Editora.campoNome],
      where: '${Editora.campoCodigo} = ?',
      whereArgs: [codigo]
    );

    if (listaDados.isNotEmpty) {
      return Editora.fromMap(listaDados.first);
    }

    return null;
  }

  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM ${Editora.Tabela}")
    ) ?? 0;
  }
}