import 'package:isar/isar.dart';

part 'category.g.dart';

@Collection()
class Category {
  Id id = Isar.autoIncrement;
  final String name;
  final String tag;

  Category({required this.id, required this.name, required this.tag});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], tag: json['tag']);
  }
}
