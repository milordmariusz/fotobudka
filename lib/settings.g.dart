// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// ignore_for_file: type=lint
class Settings extends Table with TableInfo<Settings, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Settings(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _banerTextMeta =
      const VerificationMeta('banerText');
  late final GeneratedColumn<String> banerText = GeneratedColumn<String>(
      'banerText', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _banerIndexMeta =
      const VerificationMeta('banerIndex');
  late final GeneratedColumn<int> banerIndex = GeneratedColumn<int>(
      'banerIndex', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _delayTimeMeta =
      const VerificationMeta('delayTime');
  late final GeneratedColumn<int> delayTime = GeneratedColumn<int>(
      'delayTime', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _photosNumberMeta =
      const VerificationMeta('photosNumber');
  late final GeneratedColumn<int> photosNumber = GeneratedColumn<int>(
      'photosNumber', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, banerText, banerIndex, delayTime, photosNumber];
  @override
  String get aliasedName => _alias ?? 'settings';
  @override
  String get actualTableName => 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('banerText')) {
      context.handle(_banerTextMeta,
          banerText.isAcceptableOrUnknown(data['banerText']!, _banerTextMeta));
    }
    if (data.containsKey('banerIndex')) {
      context.handle(
          _banerIndexMeta,
          banerIndex.isAcceptableOrUnknown(
              data['banerIndex']!, _banerIndexMeta));
    }
    if (data.containsKey('delayTime')) {
      context.handle(_delayTimeMeta,
          delayTime.isAcceptableOrUnknown(data['delayTime']!, _delayTimeMeta));
    }
    if (data.containsKey('photosNumber')) {
      context.handle(
          _photosNumberMeta,
          photosNumber.isAcceptableOrUnknown(
              data['photosNumber']!, _photosNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      banerText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}banerText']),
      banerIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}banerIndex']),
      delayTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}delayTime']),
      photosNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}photosNumber']),
    );
  }

  @override
  Settings createAlias(String alias) {
    return Settings(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String? banerText;
  final int? banerIndex;
  final int? delayTime;
  final int? photosNumber;
  const Setting(
      {required this.id,
      this.banerText,
      this.banerIndex,
      this.delayTime,
      this.photosNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || banerText != null) {
      map['banerText'] = Variable<String>(banerText);
    }
    if (!nullToAbsent || banerIndex != null) {
      map['banerIndex'] = Variable<int>(banerIndex);
    }
    if (!nullToAbsent || delayTime != null) {
      map['delayTime'] = Variable<int>(delayTime);
    }
    if (!nullToAbsent || photosNumber != null) {
      map['photosNumber'] = Variable<int>(photosNumber);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      banerText: banerText == null && nullToAbsent
          ? const Value.absent()
          : Value(banerText),
      banerIndex: banerIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(banerIndex),
      delayTime: delayTime == null && nullToAbsent
          ? const Value.absent()
          : Value(delayTime),
      photosNumber: photosNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(photosNumber),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      banerText: serializer.fromJson<String?>(json['banerText']),
      banerIndex: serializer.fromJson<int?>(json['banerIndex']),
      delayTime: serializer.fromJson<int?>(json['delayTime']),
      photosNumber: serializer.fromJson<int?>(json['photosNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'banerText': serializer.toJson<String?>(banerText),
      'banerIndex': serializer.toJson<int?>(banerIndex),
      'delayTime': serializer.toJson<int?>(delayTime),
      'photosNumber': serializer.toJson<int?>(photosNumber),
    };
  }

  Setting copyWith(
          {int? id,
          Value<String?> banerText = const Value.absent(),
          Value<int?> banerIndex = const Value.absent(),
          Value<int?> delayTime = const Value.absent(),
          Value<int?> photosNumber = const Value.absent()}) =>
      Setting(
        id: id ?? this.id,
        banerText: banerText.present ? banerText.value : this.banerText,
        banerIndex: banerIndex.present ? banerIndex.value : this.banerIndex,
        delayTime: delayTime.present ? delayTime.value : this.delayTime,
        photosNumber:
            photosNumber.present ? photosNumber.value : this.photosNumber,
      );
  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('banerText: $banerText, ')
          ..write('banerIndex: $banerIndex, ')
          ..write('delayTime: $delayTime, ')
          ..write('photosNumber: $photosNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, banerText, banerIndex, delayTime, photosNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.banerText == this.banerText &&
          other.banerIndex == this.banerIndex &&
          other.delayTime == this.delayTime &&
          other.photosNumber == this.photosNumber);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<String?> banerText;
  final Value<int?> banerIndex;
  final Value<int?> delayTime;
  final Value<int?> photosNumber;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.banerText = const Value.absent(),
    this.banerIndex = const Value.absent(),
    this.delayTime = const Value.absent(),
    this.photosNumber = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.banerText = const Value.absent(),
    this.banerIndex = const Value.absent(),
    this.delayTime = const Value.absent(),
    this.photosNumber = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<String>? banerText,
    Expression<int>? banerIndex,
    Expression<int>? delayTime,
    Expression<int>? photosNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (banerText != null) 'banerText': banerText,
      if (banerIndex != null) 'banerIndex': banerIndex,
      if (delayTime != null) 'delayTime': delayTime,
      if (photosNumber != null) 'photosNumber': photosNumber,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? banerText,
      Value<int?>? banerIndex,
      Value<int?>? delayTime,
      Value<int?>? photosNumber}) {
    return SettingsCompanion(
      id: id ?? this.id,
      banerText: banerText ?? this.banerText,
      banerIndex: banerIndex ?? this.banerIndex,
      delayTime: delayTime ?? this.delayTime,
      photosNumber: photosNumber ?? this.photosNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (banerText.present) {
      map['banerText'] = Variable<String>(banerText.value);
    }
    if (banerIndex.present) {
      map['banerIndex'] = Variable<int>(banerIndex.value);
    }
    if (delayTime.present) {
      map['delayTime'] = Variable<int>(delayTime.value);
    }
    if (photosNumber.present) {
      map['photosNumber'] = Variable<int>(photosNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('banerText: $banerText, ')
          ..write('banerIndex: $banerIndex, ')
          ..write('delayTime: $delayTime, ')
          ..write('photosNumber: $photosNumber')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final Settings settings = Settings(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [settings];
}
