import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:flutter/material.dart';

class LivrosPage extends StatefulWidget {
  final Editora editora;

  const LivrosPage(this.editora, {Key? key}) : super(key: key);

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editora.nome),
        centerTitle: true,
      ),
    );
  }
}
