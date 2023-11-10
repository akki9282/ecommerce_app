import 'package:drift/drift.dart';

class CartValues extends Table {
  Set<Column> get primaryKey => {id};
  IntColumn get id => integer()();
  TextColumn get title => text()();
  RealColumn get price => real()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  TextColumn get image_url => text()();
  IntColumn get quantity => integer()();
}
