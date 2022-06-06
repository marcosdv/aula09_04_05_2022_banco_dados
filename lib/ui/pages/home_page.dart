import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/enums/botao_enum.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/components/components.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/pages/pages.dart';
import 'package:flutter/material.dart';

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
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          child: _criarItemLista(listaEditora[index]),
          background: Container(
            alignment: const Alignment(-1, 0),
            color: Colors.blue,
            child: const Text("Editar Editora",
              style: TextStyle(color: Colors.white, fontSize: 18),),
          ),
          secondaryBackground: Container(
            alignment: const Alignment(1, 0),
            color: Colors.red,
            child: const Text("Excluir Editora",
              style: TextStyle(color: Colors.white, fontSize: 18),),
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              _editoraHelper.apagar(listaEditora[index]);
            }
            else if (direction == DismissDirection.startToEnd) {
              _abrirCadastroEditora(editora: listaEditora[index]);
            }
          },
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.endToStart) {
              return await MensagemAlerta().show(
                context: context,
                titulo: 'Atenção',
                texto: 'Deseja excluir essa editora?',
                botoes: [
                  Botao(texto: 'Sim', tipo: BotaoEnum.texto, clique: () {
                    Navigator.of(context).pop(true);
                  },),
                  Botao(texto: 'Não', clique: () {
                    Navigator.of(context).pop(false);
                  },),
                ]
              );
            }
            return true;
          },
        );
      },
    );
  }

  Widget _criarItemLista(Editora editora) {
    return GestureDetector(
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(editora.nome, style: TextStyle(fontSize: 30),),
            ),
          ],
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