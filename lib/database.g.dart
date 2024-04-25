// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UtilisateurDao? _utilisateurDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `utilisateur` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nom` TEXT NOT NULL, `prenom` TEXT NOT NULL, `telephone` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UtilisateurDao get utilisateurDao {
    return _utilisateurDaoInstance ??=
        _$UtilisateurDao(database, changeListener);
  }
}

class _$UtilisateurDao extends UtilisateurDao {
  _$UtilisateurDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _utilisateurInsertionAdapter = InsertionAdapter(
            database,
            'utilisateur',
            (Utilisateur item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'prenom': item.prenom,
                  'telephone': item.telephone
                }),
        _utilisateurUpdateAdapter = UpdateAdapter(
            database,
            'utilisateur',
            ['id'],
            (Utilisateur item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'prenom': item.prenom,
                  'telephone': item.telephone
                }),
        _utilisateurDeletionAdapter = DeletionAdapter(
            database,
            'utilisateur',
            ['id'],
            (Utilisateur item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'prenom': item.prenom,
                  'telephone': item.telephone
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Utilisateur> _utilisateurInsertionAdapter;

  final UpdateAdapter<Utilisateur> _utilisateurUpdateAdapter;

  final DeletionAdapter<Utilisateur> _utilisateurDeletionAdapter;

  @override
  Future<List<Utilisateur>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM utilisateur',
        mapper: (Map<String, Object?> row) => Utilisateur(
            id: row['id'] as int?,
            nom: row['nom'] as String,
            prenom: row['prenom'] as String,
            telephone: row['telephone'] as String));
  }

  @override
  Future<Utilisateur?> fintUser(int id) async {
    return _queryAdapter.query('SELECT * FROM utilisateur WHERE id= ?1',
        mapper: (Map<String, Object?> row) => Utilisateur(
            id: row['id'] as int?,
            nom: row['nom'] as String,
            prenom: row['prenom'] as String,
            telephone: row['telephone'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertUtilisateur(Utilisateur user) async {
    await _utilisateurInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateUtilisateur(Utilisateur user) {
    return _utilisateurUpdateAdapter.updateAndReturnChangedRows(
        user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUtilisateur(Utilisateur user) async {
    await _utilisateurDeletionAdapter.delete(user);
  }
}
