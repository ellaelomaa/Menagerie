class NoteModel {
  final int?
      id; // Not mandatory, as the id will be null when the item is first created, before insertion to database.
  final String name;
  final String? content;
  final String added;
  final String? modified;

  NoteModel(
      {this.id,
      required this.name,
      this.content,
      required this.added,
      this.modified});

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
      id: json["id"],
      name: json["name"],
      content: json["content"],
      added: json["added"],
      modified: json["modified"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "content": content,
      "added": added,
      "modified": modified
    };
  }
}