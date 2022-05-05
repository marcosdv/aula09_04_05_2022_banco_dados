import 'package:aula09_04_05_2022_banco_dados/models/models.dart';

class Livro {
  static const Tabela = 'TbLivro';
  static const campoCodigo = 'codigo';
  static const campoNome = 'nome';
  static const campoEditora = 'editora';

  int codigo;
  String nome;
  Editora editora;

  Livro({
    required this.codigo,
    required this.nome,
    required this.editora
  });
}