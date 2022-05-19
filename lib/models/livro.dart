import 'package:aula09_04_05_2022_banco_dados/extensions/extensions.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';

class Livro {
  static const Tabela = 'TbLivro';
  static const campoCodigo = 'codigo';
  static const campoNome = 'nome';
  static const campoEditora = 'editora';

  int? codigo;
  String nome;
  Editora editora;

  Livro({
    this.codigo,
    required this.nome,
    required this.editora
  });

  factory Livro.fromMap(Map map, Editora editora) {
    return Livro(
      codigo: map[campoCodigo].toString().toInt(),
      nome: map[campoNome],
      editora: editora
    );
  }

  Map<String, dynamic> toMap() {
    return {
      campoCodigo: codigo,
      campoNome: nome,
      campoEditora: editora.codigo
    };
  }
}