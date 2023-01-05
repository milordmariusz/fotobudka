import 'package:drift/drift.dart';

part 'data.g.dart';

class Settings extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get banerText => text()();
  IntColumn get banerIndex => integer()();
  IntColumn get delayTime => integer()();
  IntColumn get photosNumber => integer()();
}

abstract class SettingsBanerText extends View{
  Settings get settings;

  @override
  Query as() => select([
    settings.banerText
  ]).from(settings);
}

@DriftDatabase(tables:[
  Settings
], views:[
  SettingsBanerText,
])

class Database extends _$Database{
  Database(QueryExecutor e): super(e);

  @override
  int get schemaVersion => 2;

  Future UpdateDatabase(SettingsCompanion companion) {
    return (update(settings)
      ..where((t) => t.id.equals(1))
    ).write(companion);
  }
}