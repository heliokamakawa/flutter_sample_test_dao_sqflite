import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_dao_sqflite/banco/sqlite/tarefa_dao_sqlite.dart';
import 'package:flutter_test_dao_sqflite/banco/tarefa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(){
  late TarefaDAOSQLite dao;
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUp(()async{
    dao = TarefaDAOSQLite();
  });

  tearDown(()async{
    String path = join(await getDatabasesPath(), 'banco.db');
    deleteDatabase(path); // irá excluir o banco - não use na produção
  });

  test('teste salvar', ()async{
    var tarefa = Tarefa(
      nome: 'Matemática',
      descricao: 'Lista de Exercícios',
      dataEntrega: '2022-11-30'
    );
    var resultado = await dao.salvar(tarefa);
    expect(resultado, true);
  });
  test('teste alterar', ()async{
    var tarefa = Tarefa(
      id: 1,
      nome: 'Matemática',
      descricao: 'Lista de Exercícios',
      dataEntrega:  '2022-08-23'
    );
    var resultado = await dao.alterar(tarefa);
    expect(resultado, true);
  });
  test('teste excluir', ()async{
    var resultado = await dao.excluir(1);
    expect(resultado, true);
  });
  test('teste consultar um', ()async{
    var resultado = await dao.consultar(1);
    expect(resultado, isInstanceOf<Tarefa>());
  });
  test('teste listar todos', ()async{
    var resultado = await dao.listar();
    expect(resultado, isInstanceOf<List<Tarefa>>());
  });
}