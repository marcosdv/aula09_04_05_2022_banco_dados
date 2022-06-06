import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/components/components.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class LivrosPage extends StatefulWidget {
  final Editora editora;

  const LivrosPage(this.editora, {Key? key}) : super(key: key);

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  final _livroHelper = LivroHelper();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editora.nome),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _abrirCadastroLivro,
      ),
      body: FutureBuilder(
        future: _livroHelper.getByEditora(widget.editora.codigo ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const CirculoEspera();
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return _criarListagem(snapshot.data as List<Livro>);
          }
        },
      ),
    );
  }

  Widget _criarListagem(List<Livro> listaDados) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: listaDados.length,
      itemBuilder: (context, index) {
        return _criarItemLista(listaDados[index]);
      }
    );
  }

  Widget _criarItemLista(Livro livro) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text(livro.nome)
            ],
          ),
        ),
      ),
      onTap: () {
        _abrirCadastroLivro(livro: livro);
      },
    );
  }

  void _abrirCadastroLivro({Livro? livro}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadLivroPage(
          editora: widget.editora, livro: livro)
      )
    );

    setState(() { });
  }
}
