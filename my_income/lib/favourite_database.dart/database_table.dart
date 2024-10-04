import 'package:drift/drift.dart';
@DataClassName("Favourite")
class DatabaseTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title =>text()();
  TextColumn get img => text()();
  TextColumn get link =>text()();
}

/*
import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_application_1/favourite/favourite_table.dart';
import 'package:path/path.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
part 'favourite_database.g.dart';

@DriftDatabase(tables: [FavouriteTable])
class FavouriteDatabase extends _$FavouriteDatabase {
  FavouriteDatabase() : super(_database());

  Future<int> insertFavourite(FavouriteTableCompanion s) async {
    return await into(favouriteTable).insert(s);
  }

  Stream<List<Favourite>> getFavourite() {
    return select(favouriteTable).watch();
  }
  Future<int> deleteFavourite(Favourite f)async{
    return await delete(favouriteTable).delete(f);
  }
  Future<int> deleteAllFavourite()async{
    return await (delete(favouriteTable)..where((tbl) =>tbl.id.isBiggerThanValue(0) )).go();
  }
  

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(join(dbFolder.path, 'favourite.db'));
    return NativeDatabase(dbFile);
  });
}



*/