import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_dao_sqflite/banco/sqlite/conexao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late Database db;

  setUp(()async{ //executa o que foi definido antes de todos os testes
    String path = join(await getDatabasesPath(), 'banco.db');
    deleteDatabase(path); // irá excluir o banco - não use na produção
    db = await Conexao.abrir();
    
  });

  tearDown((){ //executa o que foi definido após cada teste
  });

  tearDownAll((){ //executa o que foi definido após todos os testes
    db.close();
  });

  group('teste conexao',(){ // definindo um grupo de testes
    test('teste conexão aberta', () async{
      expect(db.isOpen, true);
    });

    test('teste conexão em consulta', () async{
      var resultado = await db.query('tarefa');
      expect(resultado.length, isInstanceOf<int>());
    });
  });
}