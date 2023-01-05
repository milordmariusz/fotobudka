// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _banerTextMeta =
      const VerificationMeta('banerText');
  @override
  late final GeneratedColumn<String> banerText = GeneratedColumn<String>(
      'baner_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _banerIndexMeta =
      const VerificationMeta('banerIndex');
  @override
  late final GeneratedColumn<int> banerIndex = GeneratedColumn<int>(
      'baner_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _delayTimeMeta =
      const VerificationMeta('delayTime');
  @override
  late final GeneratedColumn<int> delayTime = GeneratedColumn<int>(
      'delay_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _photosNumberMeta =
      const VerificationMeta('photosNumber');
  @override
  late final GeneratedColumn<int> photosNumber = GeneratedColumn<int>(
      'photos_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
    if (data.containsKey('baner_text')) {
      context.handle(_banerTextMeta,
          banerText.isAcceptableOrUnknown(data['baner_text']!, _banerTextMeta));
    } else if (isInserting) {
      context.missing(_banerTextMeta);
    }
    if (data.containsKey('baner_index')) {
      context.handle(
          _banerIndexMeta,
          banerIndex.isAcceptableOrUnknown(
              data['baner_index']!, _banerIndexMeta));
    } else if (isInserting) {
      context.missing(_banerIndexMeta);
    }
    if (data.containsKey('delay_time')) {
      context.handle(_delayTimeMeta,
          delayTime.isAcceptableOrUnknown(data['delay_time']!, _delayTimeMeta));
    } else if (isInserting) {
      context.missing(_delayTimeMeta);
    }
    if (data.containsKey('photos_number')) {
      context.handle(
          _photosNumberMeta,
          photosNumber.isAcceptableOrUnknown(
              data['photos_number']!, _photosNumberMeta));
    } else if (isInserting) {
      context.missing(_photosNumberMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}baner_text'])!,
      banerIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}baner_index'])!,
      delayTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}delay_time'])!,
      photosNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}photos_number'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String banerText;
  final int banerIndex;
  final int delayTime;
  final int photosNumber;
  const Setting(
      {required this.id,
      required this.banerText,
      required this.banerIndex,
      required this.delayTime,
      required this.photosNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baner_text'] = Variable<String>(banerText);
    map['baner_index'] = Variable<int>(banerIndex);
    map['delay_time'] = Variable<int>(delayTime);
    map['photos_number'] = Variable<int>(photosNumber);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      banerText: Value(banerText),
      banerIndex: Value(banerIndex),
      delayTime: Value(delayTime),
      photosNumber: Value(photosNumber),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      banerText: serializer.fromJson<String>(json['banerText']),
      banerIndex: serializer.fromJson<int>(json['banerIndex']),
      delayTime: serializer.fromJson<int>(json['delayTime']),
      photosNumber: serializer.fromJson<int>(json['photosNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'banerText': serializer.toJson<String>(banerText),
      'banerIndex': serializer.toJson<int>(banerIndex),
      'delayTime': serializer.toJson<int>(delayTime),
      'photosNumber': serializer.toJson<int>(photosNumber),
    };
  }

  Setting copyWith(
          {int? id,
          String? banerText,
          int? banerIndex,
          int? delayTime,
          int? photosNumber}) =>
      Setting(
        id: id ?? this.id,
        banerText: banerText ?? this.banerText,
        banerIndex: banerIndex ?? this.banerIndex,
        delayTime: delayTime ?? this.delayTime,
        photosNumber: photosNumber ?? this.photosNumber,
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
  final Value<String> banerText;
  final Value<int> banerIndex;
  final Value<int> delayTime;
  final Value<int> photosNumber;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.banerText = const Value.absent(),
    this.banerIndex = const Value.absent(),
    this.delayTime = const Value.absent(),
    this.photosNumber = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    required String banerText,
    required int banerIndex,
    required int delayTime,
    required int photosNumber,
  })  : banerText = Value(banerText),
        banerIndex = Value(banerIndex),
        delayTime = Value(delayTime),
        photosNumber = Value(photosNumber);
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<String>? banerText,
    Expression<int>? banerIndex,
    Expression<int>? delayTime,
    Expression<int>? photosNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (banerText != null) 'baner_text': banerText,
      if (banerIndex != null) 'baner_index': banerIndex,
      if (delayTime != null) 'delay_time': delayTime,
      if (photosNumber != null) 'photos_number': photosNumber,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? banerText,
      Value<int>? banerIndex,
      Value<int>? delayTime,
      Value<int>? photosNumber}) {
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
      map['baner_text'] = Variable<String>(banerText.value);
    }
    if (banerIndex.present) {
      map['baner_index'] = Variable<int>(banerIndex.value);
    }
    if (delayTime.present) {
      map['delay_time'] = Variable<int>(delayTime.value);
    }
    if (photosNumber.present) {
      map['photos_number'] = Variable<int>(photosNumber.value);
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

class SettingsBanerTextData extends DataClass {
  final String banerText;
  const SettingsBanerTextData({required this.banerText});
  factory SettingsBanerTextData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsBanerTextData(
      banerText: serializer.fromJson<String>(json['banerText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'banerText': serializer.toJson<String>(banerText),
    };
  }

  SettingsBanerTextData copyWith({String? banerText}) => SettingsBanerTextData(
        banerText: banerText ?? this.banerText,
      );
  @override
  String toString() {
    return (StringBuffer('SettingsBanerTextData(')
          ..write('banerText: $banerText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => banerText.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsBanerTextData && other.banerText == this.banerText);
}

class $SettingsBanerTextView
    extends ViewInfo<$SettingsBanerTextView, SettingsBanerTextData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $SettingsBanerTextView(this.attachedDatabase, [this._alias]);
  $SettingsTable get settings => attachedDatabase.settings.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [banerText];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'settings_baner_text';
  @override
  String? get createViewStmt => null;
  @override
  $SettingsBanerTextView get asDslTable => this;
  @override
  SettingsBanerTextData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsBanerTextData(
      banerText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}baner_text'])!,
    );
  }

  late final GeneratedColumn<String> banerText = GeneratedColumn<String>(
      'baner_text', aliasedName, false,
      generatedAs: GeneratedAs(settings.banerText, false),
      type: DriftSqlType.string);
  @override
  $SettingsBanerTextView createAlias(String alias) {
    return $SettingsBanerTextView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(settings)..addColumns($columns));
  @override
  Set<String> get readTables => const {'settings'};
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $SettingsBanerTextView settingsBanerText =
      $SettingsBanerTextView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [settings, settingsBanerText];
}
