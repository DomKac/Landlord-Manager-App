// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlotDAO? _plotDaoInstance;

  ObjectDAO? _objectDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `MyPlot` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `plotName` TEXT NOT NULL, `imagePath` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MyObject` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `plotId` INTEGER NOT NULL, `objectName` TEXT NOT NULL, `color` TEXT NOT NULL, `category` TEXT NOT NULL, `notes` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlotDAO get plotDao {
    return _plotDaoInstance ??= _$PlotDAO(database, changeListener);
  }

  @override
  ObjectDAO get objectDao {
    return _objectDaoInstance ??= _$ObjectDAO(database, changeListener);
  }
}

class _$PlotDAO extends PlotDAO {
  _$PlotDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _myPlotInsertionAdapter = InsertionAdapter(
            database,
            'MyPlot',
            (MyPlot item) => <String, Object?>{
                  'id': item.id,
                  'plotName': item.plotName,
                  'imagePath': item.imagePath
                },
            changeListener),
        _myPlotUpdateAdapter = UpdateAdapter(
            database,
            'MyPlot',
            ['id'],
            (MyPlot item) => <String, Object?>{
                  'id': item.id,
                  'plotName': item.plotName,
                  'imagePath': item.imagePath
                },
            changeListener),
        _myPlotDeletionAdapter = DeletionAdapter(
            database,
            'MyPlot',
            ['id'],
            (MyPlot item) => <String, Object?>{
                  'id': item.id,
                  'plotName': item.plotName,
                  'imagePath': item.imagePath
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MyPlot> _myPlotInsertionAdapter;

  final UpdateAdapter<MyPlot> _myPlotUpdateAdapter;

  final DeletionAdapter<MyPlot> _myPlotDeletionAdapter;

  @override
  Future<List<MyPlot>> findAllPlots() async {
    return _queryAdapter.queryList('SELECT * FROM MyPlot',
        mapper: (Map<String, Object?> row) => MyPlot(
            plotName: row['plotName'] as String,
            imagePath: row['imagePath'] as String,
            id: row['id'] as int?));
  }

  @override
  Stream<List<MyPlot>> watchAllPlots() {
    return _queryAdapter.queryListStream('SELECT * FROM MyPlot',
        mapper: (Map<String, Object?> row) => MyPlot(
            plotName: row['plotName'] as String,
            imagePath: row['imagePath'] as String,
            id: row['id'] as int?),
        queryableName: 'MyPlot',
        isView: false);
  }

  @override
  Future<void> addPlot(MyPlot plot) async {
    await _myPlotInsertionAdapter.insert(plot, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlot(MyPlot plot) async {
    await _myPlotUpdateAdapter.update(plot, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePlot(MyPlot plot) async {
    await _myPlotDeletionAdapter.delete(plot);
  }
}

class _$ObjectDAO extends ObjectDAO {
  _$ObjectDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _myObjectInsertionAdapter = InsertionAdapter(
            database,
            'MyObject',
            (MyObject item) => <String, Object?>{
                  'id': item.id,
                  'plotId': item.plotId,
                  'objectName': item.objectName,
                  'color': item.color,
                  'category': item.category,
                  'notes': item.notes
                },
            changeListener),
        _myObjectUpdateAdapter = UpdateAdapter(
            database,
            'MyObject',
            ['id'],
            (MyObject item) => <String, Object?>{
                  'id': item.id,
                  'plotId': item.plotId,
                  'objectName': item.objectName,
                  'color': item.color,
                  'category': item.category,
                  'notes': item.notes
                },
            changeListener),
        _myObjectDeletionAdapter = DeletionAdapter(
            database,
            'MyObject',
            ['id'],
            (MyObject item) => <String, Object?>{
                  'id': item.id,
                  'plotId': item.plotId,
                  'objectName': item.objectName,
                  'color': item.color,
                  'category': item.category,
                  'notes': item.notes
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MyObject> _myObjectInsertionAdapter;

  final UpdateAdapter<MyObject> _myObjectUpdateAdapter;

  final DeletionAdapter<MyObject> _myObjectDeletionAdapter;

  @override
  Future<List<MyObject>> findAllObjects() async {
    return _queryAdapter.queryList('SELECT * FROM MyObject',
        mapper: (Map<String, Object?> row) => MyObject(
            plotId: row['plotId'] as int,
            objectName: row['objectName'] as String,
            color: row['color'] as String,
            category: row['category'] as String,
            notes: row['notes'] as String,
            id: row['id'] as int?));
  }

  @override
  Stream<List<MyObject>> watchAllObjects() {
    return _queryAdapter.queryListStream('SELECT * FROM MyObject',
        mapper: (Map<String, Object?> row) => MyObject(
            plotId: row['plotId'] as int,
            objectName: row['objectName'] as String,
            color: row['color'] as String,
            category: row['category'] as String,
            notes: row['notes'] as String,
            id: row['id'] as int?),
        queryableName: 'MyObject',
        isView: false);
  }

  @override
  Future<void> addObject(MyObject object) async {
    await _myObjectInsertionAdapter.insert(object, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateObject(MyObject object) async {
    await _myObjectUpdateAdapter.update(object, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteObject(MyObject object) async {
    await _myObjectDeletionAdapter.delete(object);
  }
}
