import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:sqflite/sqflite.dart';

class LivroHelper {
  static const createSql = '''
    CREATE TABLE IF NOT EXISTS ${Livro.Tabela} (
      ${Livro.campoCodigo} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Livro.campoNome} TEXT,
      ${Livro.campoEditora} INTEGER,
      FOREIGN KEY(${Livro.campoEditora})
        REFERENCES ${Editora.Tabela}(${Editora.campoCodigo})
    )
  ''';

  Future<Livro> inserir(Livro livro) async {
    Database db = await BancoDados().db;

    livro.codigo = await db.insert(Livro.Tabela, livro.toMap());

    db.close();
    return livro;
  }

  Future<int> alterar(Livro livro) async {
    Database db = await BancoDados().db;

    int linhasAfetadas = await db.update(
      Livro.Tabela,
      livro.toMap(),
      where: '${Livro.campoCodigo} = ?',
      whereArgs: [livro.codigo]
    );

    db.close();
    return linhasAfetadas;
  }

  Future<int> apagar(Livro livro) async {
    Database db = await BancoDados().db;

    int linhasAfetadas = await db.delete(
      Livro.Tabela,
      where: '${Livro.campoCodigo} = ?',
      whereArgs: [livro.codigo]
    );

    db.close();
    return linhasAfetadas;
  }

  Future<List<Livro>> getByEditora(int codEditora) async {
    Editora? editora = await EditoraHelper().getEditora(codEditora);

    if (editora != null) {
      Database db = await BancoDados().db;

      List listaDados = await db.query(
        Livro.Tabela,
        where: '${Livro.campoEditora} = ?',
        whereArgs: [codEditora],
        orderBy: Livro.campoNome
      );
      return listaDados.map((e) => Livro.fromMap(e, editora)).toList();
    }

    return [];
  }
}