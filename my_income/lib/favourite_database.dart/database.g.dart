// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DatabaseTableTable extends DatabaseTable
    with TableInfo<$DatabaseTableTable, Favourite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatabaseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imgMeta = const VerificationMeta('img');
  @override
  late final GeneratedColumn<String> img = GeneratedColumn<String>(
      'img', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, img, link];
  @override
  String get aliasedName => _alias ?? 'database_table';
  @override
  String get actualTableName => 'database_table';
  @override
  VerificationContext validateIntegrity(Insertable<Favourite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('img')) {
      context.handle(
          _imgMeta, img.isAcceptableOrUnknown(data['img']!, _imgMeta));
    } else if (isInserting) {
      context.missing(_imgMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favourite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favourite(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      img: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
    );
  }

  @override
  $DatabaseTableTable createAlias(String alias) {
    return $DatabaseTableTable(attachedDatabase, alias);
  }
}

class Favourite extends DataClass implements Insertable<Favourite> {
  final int id;
  final String title;
  final String img;
  final String link;
  const Favourite(
      {required this.id,
      required this.title,
      required this.img,
      required this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['img'] = Variable<String>(img);
    map['link'] = Variable<String>(link);
    return map;
  }

  DatabaseTableCompanion toCompanion(bool nullToAbsent) {
    return DatabaseTableCompanion(
      id: Value(id),
      title: Value(title),
      img: Value(img),
      link: Value(link),
    );
  }

  factory Favourite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favourite(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      img: serializer.fromJson<String>(json['img']),
      link: serializer.fromJson<String>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'img': serializer.toJson<String>(img),
      'link': serializer.toJson<String>(link),
    };
  }

  Favourite copyWith({int? id, String? title, String? img, String? link}) =>
      Favourite(
        id: id ?? this.id,
        title: title ?? this.title,
        img: img ?? this.img,
        link: link ?? this.link,
      );
  @override
  String toString() {
    return (StringBuffer('Favourite(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('img: $img, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, img, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favourite &&
          other.id == this.id &&
          other.title == this.title &&
          other.img == this.img &&
          other.link == this.link);
}

class DatabaseTableCompanion extends UpdateCompanion<Favourite> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> img;
  final Value<String> link;
  const DatabaseTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.img = const Value.absent(),
    this.link = const Value.absent(),
  });
  DatabaseTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String img,
    required String link,
  })  : title = Value(title),
        img = Value(img),
        link = Value(link);
  static Insertable<Favourite> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? img,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (img != null) 'img': img,
      if (link != null) 'link': link,
    });
  }

  DatabaseTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? img,
      Value<String>? link}) {
    return DatabaseTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      img: img ?? this.img,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (img.present) {
      map['img'] = Variable<String>(img.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('img: $img, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $DatabaseTableTable databaseTable = $DatabaseTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [databaseTable];
}
