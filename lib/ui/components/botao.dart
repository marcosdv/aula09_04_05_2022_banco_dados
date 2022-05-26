import 'package:aula09_04_05_2022_banco_dados/enums/botao_enum.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final BotaoEnum tipo;
  final VoidCallback clique;

  const Botao({
    required this.texto,
    this.tipo = BotaoEnum.quadrado,
    required this.clique,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (tipo) {
      case BotaoEnum.quadrado: return _criarBotaoQuadrado();
      case BotaoEnum.texto: return _criarBotaoTexto();
      default: return Container();
    }
  }

  Widget _criarBotaoTexto() {
    return TextButton(child: Text(texto), onPressed: clique);
  }

  Widget _criarBotaoQuadrado() {
    return ElevatedButton(child: Text(texto), onPressed: clique);
  }
}
