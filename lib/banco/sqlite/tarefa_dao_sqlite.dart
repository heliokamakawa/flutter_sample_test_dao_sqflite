import 'package:flutter_test_dao_sqflite/banco/sqlite/conexao.dart';
import 'package:flutter_test_dao_sqflite/banco/tarefa.dart';
import 'package:sqflite/sqflite.dart';

class TarefaDAOSQLite {
  
  Future<bool> salvar(Tarefa tarefa) async {
    Database db = await Conexao.abrir();
    const sql = 'INSERT INTO tarefa (nome, descricao, data_entrega) VALUES (?,?,?)';
    var linhasAfetadas = await db.rawInsert(sql,[tarefa.nome,tarefa.descricao,tarefa.dataEntrega.toString()]);
    return linhasAfetadas > 0;
  }
  
  Future<bool> alterar(Tarefa tarefa) async {
    const sql = 'UPDATE tarefa SET nome=?, descricao=?, data_entrega=? WHERE id = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(sql,[tarefa.nome, tarefa.dataEntrega, tarefa.dataEntrega, tarefa.id]);
    return linhasAfetadas > 0;
  }
  
  Future<Tarefa> consultar(int id) async {
    late Database db;
    try{
      const sql = 'SELECT * FROM tarefa WHERE id = ?';
      db = await Conexao.abrir();
      Map<String,Object?> resultado = (await db.rawQuery(sql,[id])).first;
      if(resultado.isEmpty) throw Exception('Sem registros com este id');
      Tarefa tarefa = Tarefa(id: resultado['id'] as int, nome: resultado['nome'].toString(), descricao: resultado['descricao'].toString(), dataEntrega: resultado['data_entrega'].toString() );
      return tarefa;
    }catch(e){
      throw Exception('classe TarefaDAOSQLite, método consultar');
    } finally {
      db.close();
    }
  }
  
  Future<bool> excluir(int id) async{
    late Database db;
    try{
      const sql = 'DELETE FROM tarefa WHERE id = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql,[id]);
      return linhasAfetadas > 0;
    }catch(e){
      throw Exception('classe TarefaDAOSQLite, método excluir');
    } finally {
      db.close();
    }
  }
  
  @override
  Future<List<Tarefa>> listar() async {
    late Database db;
    try{
      const sql = 'SELECT * FROM tarefa';
      db = await Conexao.abrir();
      List<Map<String,Object?>> resultado = (await db.rawQuery(sql));
      if(resultado.isEmpty) throw Exception('Sem registros');
      List<Tarefa> tarefas = resultado.map((linha) { 
        return Tarefa(
          id: linha['id'] as int, 
          nome: linha['nome'].toString(), 
          descricao: linha['descricao'].toString(), 
          dataEntrega: linha['data_entrega'].toString() );
      }).toList() ;
      return tarefas;
    }catch(e){
      throw Exception('classe TarefaDAOSQLite, método listar');
    } finally {
      db.close();
    }
  }
}