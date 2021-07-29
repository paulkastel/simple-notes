import 'package:equatable/equatable.dart';

class Note extends Equatable {
  Note(this.content, this.creationDate);

  Note.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        content = json['content'],
        creationDate = DateTime.parse(json['creationdate']);

  final String content;
  final DateTime creationDate;

  int? _id;

  @override
  List<Object?> get props => [_id, content, creationDate];

  @override
  String toString() {
    return content;
  }

  int? get id => _id;

  static List<Note> listFromJson(List<Map<String, dynamic>>? json) {
    return json == null ? <Note>[] : json.map((c) => Note.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'content': content,
      'creationdate': creationDate.toIso8601String(),
    };
  }
}
