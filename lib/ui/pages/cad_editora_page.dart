import 'package:aula09_04_05_2022_banco_dados/datasources/datasources.dart';
import 'package:aula09_04_05_2022_banco_dados/enums/botao_enum.dart';
import 'package:aula09_04_05_2022_banco_dados/models/models.dart';
import 'package:aula09_04_05_2022_banco_dados/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadEditoraPage extends StatefulWidget {
  final Editora? editora;

  const CadEditoraPage({this.editora, Key? key}) : super(key: key);

  @override
  State<CadEditoraPage> createState() => _CadEditoraPageState();
}

class _CadEditoraPageState extends State<CadEditoraPage> {
  final _editoraHelper = EditoraHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editora != null) {
      _nomeController.text = widget.editora!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Editora'), centerTitle: true),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: 'Nome da editora'),
          Botao(texto: 'Salvar', clique: _salvarEditora),
          _criarBotaoExcluir(),
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.editora != null) {
      return Botao(texto: 'Excluir', clique: _excluirEditora,);
    }
    return Container();
  }

  void _excluirEditora() {
    MensagemAlerta().show(
      context: context,
      titulo: 'Atenção',
      texto: 'Deseja realmente excluir essa editora?',
      botoes: [
        Botao(texto: 'Sim', tipo: BotaoEnum.texto, clique: _confirmaExclusao),
        Botao(texto: 'Não', clique: (){ Navigator.pop(context); }),
      ]
    );
  }

  void _confirmaExclusao() {
    if (widget.editora != null) {
      _editoraHelper.apagar(widget.editora!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarEditora() {
    if (_nomeController.text.trim().isEmpty) {
      MensagemAlerta().show(
        context: context,
        titulo: 'Atenção',
        texto: 'Digite o nome da Editora!',
        botoes: [
          Botao(texto: 'OK', tipo: BotaoEnum.texto,
              clique: (){ Navigator.pop(context); })
        ]
      );

      return;
    }

    if (widget.editora == null) {
      _editoraHelper.inserir(Editora(nome: _nomeController.text));
    }
    else {
      _editoraHelper.alterar(Editora(
        codigo: widget.editora!.codigo,
        nome: _nomeController.text
      ));
    }

    Navigator.pop(context);
  }
}
