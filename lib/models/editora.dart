import 'package:aula09_04_05_2022_banco_dados/extensions/extensions.dart';

class Editora {
  static const Tabela = 'TbEditora';
  static const campoCodigo = 'codigo';
  static const campoNome = 'nome';

  int? codigo;
  String nome;

  Editora({this.codigo, required this.nome});

  factory Editora.fromMap(Map mapa) {
    return Editora(
      codigo: mapa[campoCodigo].toString().toInt(),
      nome: mapa[campoNome]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      campoCodigo: codigo,
      campoNome: nome
    };
  }
}