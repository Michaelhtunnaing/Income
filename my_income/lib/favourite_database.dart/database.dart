
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:MM_TVPro/favourite_database.dart/database_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'database.g.dart';
@DriftDatabase(tables: [DatabaseTable])
class Database extends _$Database{
  Database() : super(_database());

  @override
 
  int get schemaVersion => 1;

     Future<int> insertFavourite(DatabaseTableCompanion s) async {
    return await into(databaseTable).insert(s);
  }

  Stream<List<Favourite>> getFavourite() {
    return select(databaseTable).watch();
  }

  Future<int> deleteFavourite(Favourite f) async {
    return await delete(databaseTable).delete(f);
  }

  Future<int> deleteAllFavourite() async {
    return await (delete(databaseTable)
          ..where((tbl) => tbl.id.isBiggerThanValue(0)))
        .go();
  }
  

}
LazyDatabase _database(){
  return LazyDatabase(()async{
    final dbFolder =await getApplicationDocumentsDirectory();
    final dbFile = File(path.join(dbFolder.path,'favourite'));
    return NativeDatabase(dbFile);
  });
}