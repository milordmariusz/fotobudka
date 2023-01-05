import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'settings.g.dart';
@DriftDatabase(
  include: {'settings.drift'},
)
class Database extends _$Database {
  Database() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future UpdateDatabase(SettingsCompanion companion) {
    return (update(settings)
      ..where((t) => t.id.equals(1))
    ).write(companion);
  }

  Future<List<Setting>> getSettings() async {
    return await select(settings).get();
  }

  Future deleteSettings(int id) async {
    return (delete(settings).where((tbl) => tbl.id.equals(id)));
  }

  Future<int> saveSettings(SettingsCompanion companion) async {
    return await into(settings).insert(companion);
  }

}
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'settings.db'));
    return NativeDatabase(file);
  });
}