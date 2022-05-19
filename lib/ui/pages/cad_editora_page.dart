import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadEditoraPage extends StatefulWidget {
  const CadEditoraPage({Key? key}) : super(key: key);

  @override
  State<CadEditoraPage> createState() => _CadEditoraPageState();
}

class _CadEditoraPageState extends State<CadEditoraPage> {
  final _editoraHelper = EditoraHelper();
  final _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Editora'), centerTitle: true),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: 'Nome da editora'),
          ElevatedButton(
            child: Text('Salvar'),
            onPressed: () {
              _editoraHelper.inserir(Editora(nome: _nomeController.text));
            },
          ),
        ],
      ),
    );
  }
}
