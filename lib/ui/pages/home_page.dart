import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/components/components.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/pages/pages.dart';
import 'package:flutter/material.dart';

import 'livros_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _editoraHelper = EditoraHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Livros'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){ _abrirCadastroEditora(); },
      ),
      body: FutureBuilder(
        future: _editoraHelper.getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CirculoEspera();
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              else {
                return _criarListaEditora(snapshot.data as List<Editora>);
              }
          }
        },
      ),
    );
  }

  Widget _criarListaEditora(List<Editora> listaEditora) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: listaEditora.length,
      itemBuilder: (context, index) {
        return _criarItemLista(listaEditora[index]);
      },
    );
  }

  Widget _criarItemLista(Editora editora) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(editora.nome, style: TextStyle(fontSize: 30),),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => LivrosPage(editora)));
      },
      onLongPress: () {
        _abrirCadastroEditora(editora: editora);
      },
    );
  }

  void _abrirCadastroEditora({Editora? editora}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadEditoraPage(editora: editora,)));

    setState(() { });
  }
}