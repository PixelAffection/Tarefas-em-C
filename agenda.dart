import 'dart:async';
import 'dart:io';

import 'package:agenda/agenda.dart';
import 'package:agenda/contato.dart';

Future<void> main(List<String> arguments) async {
  List<String> menuOptions;
  Agenda agenda = Agenda();

  menuOptions = [
    '1 - Inserir na agenda',
    '2 - Consultar na agenda',
    '3 - Excluir da agenda',
    '4 - Listar a agenda',
    '0 - Sair\n\n',
  ];

  clear();

  stdout.writeAll(menuOptions, '\n');
  var op = stdin.readLineSync();
  while (op != '0') {
    clear();
    switch (op) {
      case '1':
        agenda.inserir(getContatoFromUserInput());

        break;
      case '2':
        stdout.write('Consultar na agenda:\n');

        stdout.write('Nome:');

        var nome = stdin.readLineSync();

        stdout.writeln();

        var contato = agenda.contatos.firstWhere(
          (element) => element.nome == nome,
          orElse: () {
            clear();
            stdout.write('Contato não cadastrado.');
            return null;
          },
        );

        if (contato != null) {
          stdout.write(contato);
        }

        break;
      case '3':
        stdout.write('Excluir da agenda:\n');

        stdout.write('Nome:');

        var nome = stdin.readLineSync();

        stdout.writeln();

        var contato = agenda.contatos.firstWhere(
          (element) => element.nome == nome,
          orElse: () {
            clear();
            stdout.write('Contato não cadastrado.');
            return null;
          },
        );

        if (contato != null) {
          stdout.write(contato);
          stdout.write('Deseja mesmo excluir o contato?[S/N]\n');
          var yesOrNo = stdin.readLineSync();
          stdout.writeln();
          if (yesOrNo.toLowerCase().startsWith('s')) {
            agenda.excluir(contato);
            stdout.write('O contato foi excluído!\n');
          }
        }

        break;
      case '4':
        agenda.listar();
        break;
      default:
        stdout.write('Digite uma opção válida!\n');
    }
    stdout.write('\n\n');

    stdout.write('Digite [ENTER] para voltar ao menu\n\n');
    await stdin.readLineSync();

    clear();

    stdout.writeAll(menuOptions, '\n');
    op = stdin.readLineSync();
  }
  seeYouLater();
}

void clear() {
  for (int i = 0; i < stdout.terminalLines; i++) {
    stdout.writeln();
  }
}

Contato getContatoFromUserInput() {
  var contato = Contato();

  stdout.write('Inserir contato:\n\n');

  stdout.write('Nome: ');
  contato.nome = stdin.readLineSync();

  stdout.write('Telefone: ');
  contato.telefone = stdin.readLineSync();

  stdout.write('Email: ');
  contato.email = stdin.readLineSync();

  return contato;
}

void seeYouLater() async {
  clear();
  stdout.write('Saindo!\n');
  await Future.delayed(Duration(milliseconds: 100))
      .then((value) => stdout.write('1...\n'));
  await Future.delayed(Duration(milliseconds: 100))
      .then((value) => stdout.write('2...\n'));
  await Future.delayed(Duration(milliseconds: 100))
      .then((value) => stdout.write('3...\n'));
  await Future.delayed(Duration(milliseconds: 100))
      .then((value) => stdout.write('Pronto!\n'));
}
