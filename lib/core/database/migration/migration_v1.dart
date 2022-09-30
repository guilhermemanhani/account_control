import 'package:account_control/core/database/migration/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
          CREATE TABLE banco (
            id Integer primary key autoincrement,
            instituicao VARCHAR(45) not null    
          )
        ''');

    batch.execute('''
          CREATE TABLE conta (
            id Integer primary key autoincrement,
            conta Interger(45) not null,
            saldo REAL NOT NULL,
            idbanco Interger NOT NULL,          
            FOREIGN KEY (idbanco) REFERENCES banco (id) ON DELETE NO ACTION ON UPDATE NO ACTION    
          )
        ''');
    batch.execute('''
          CREATE TABLE local (
            id Integer primary key autoincrement,
            local VARCHAR(45) not null    
          )
        ''');
    batch.execute('''
          CREATE TABLE motivo (
            id Integer primary key autoincrement,
            motivo VARCHAR(45)   
          )
        ''');
    batch.execute('''
          CREATE TABLE lancamento (
            idlancamento Integer primary key autoincrement,
            datahora datetime NOT NULL,
            valor REAL NOT NULL,
            descricao VARCHAR(45) NULL,
            idconta Interger NOT NULL,
            localid  Interger NOT NULL,
            tpagamento BOOLEAN NOT NULL,
            motivoid Interger,            
            FOREIGN KEY (idconta) REFERENCES conta (id) ON DELETE NO ACTION ON UPDATE NO ACTION
            FOREIGN KEY (localid) REFERENCES local (id) ON DELETE NO ACTION ON UPDATE NO ACTION
            FOREIGN KEY (motivoid) REFERENCES motivo (id) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
        ''');
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'Itaú',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'Nubank',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'Uniprime',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'Alelo alimentação',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'Alelo refeição',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'Santander',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'local': 'Posto',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'local': 'Mercado',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'local': 'Luz',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'local': 'Água',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'local': 'Condomínio',
      },
    );
    batch.insert(
      'motivo',
      {
        'id': null,
        'motivo': 'Férias',
      },
    );
    batch.insert(
      'motivo',
      {
        'id': null,
        'motivo': 'Viagem',
      },
    );
    batch.insert(
      'motivo',
      {
        'id': null,
        'motivo': 'Salário',
      },
    );
  }

  @override
  void update(Batch batch) {}
}
//  create table todo(
//       id Integer primary key autoincrement,
//       descricao varchar(500) not null,
//       data_hora datetime,
//       finalizado interger
//     )

// CREATE TABLE MarketInfoes ("
//      "id integer primary key, 
//      userId integer, 
//      typeId integer,"
//      "gradeId integer,
//       price DOUBLE" 
//      "FOREIGN KEY (typeId) REFERENCES Type (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
//      "FOREIGN KEY (userId) REFERENCES User (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
//      "FOREIGN KEY (gradeId) REFERENCES Grade (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
//    ")