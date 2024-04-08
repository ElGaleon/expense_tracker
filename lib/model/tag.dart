import 'package:isar/isar.dart';

part 'tag.g.dart';

@Collection()
class Tag {
  Id id = Isar.autoIncrement;
  String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'], name: json['name']);
  }
}
