import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/enums/botao_enum.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadLivroPage extends StatefulWidget {
  final Editora editora;
  final Livro? livro;

  const CadLivroPage({required this.editora, this.livro, Key? key}) : super(key: key);

  @override
  State<CadLivroPage> createState() => _CadLivroPageState();
}

class _CadLivroPageState extends State<CadLivroPage> {
  final _livroHelper = LivroHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _nomeController.text = widget.livro!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Livro'),
        centerTitle: true,
        actions: [
          Botao(icone: Icons.save, clique: _salvarLivro),
          _criarBotaoExcluir(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _salvarLivro,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CampoTexto(
              controller: _nomeController,
              texto: 'Nome do livro'
            ),
          ],
        ),
      ),
    );
  }

  void _salvarLivro() {
    if (_nomeController.text.isEmpty) {
      MensagemAlerta().show(
        context: context,
        titulo: 'Atenção',
        texto: 'Digite o nome do livro!',
        botoes: [
          Botao(texto: 'OK', tipo: BotaoEnum.texto, clique: (){
            Navigator.pop(context);
          }),
        ]
      );
      return;
    }

    if (widget.livro == null) {
      _livroHelper.inserir(Livro(
        nome: _nomeController.text, editora: widget.editora
      ));
    }
    else {
      _livroHelper.alterar(Livro(
        codigo: widget.livro!.codigo,
        nome: _nomeController.text,
        editora: widget.editora
      ));
    }

    Navigator.pop(context);
  }

  Widget _criarBotaoExcluir() {
    if (widget.livro != null) {
      return Botao(icone: Icons.delete, clique: (){},);
    }
    return Container();
  }
}
