// Can be a list or a tarot hand

class Parent {
  final int? id;
  final String title;
  final String added;
  final String? modified;
  final String type;
  final int folderId;

  Parent({
    this.id,
    required this.title,
    required this.added,
    this.modified,
    required this.type,
    required this.folderId,
  });

  factory Parent.fromMap(Map<String, dynamic> json) => Parent(
        id: json["id"],
        title: json["title"],
        added: json["added"],
        modified: json["modified"],
        type: json["type"],
        folderId: json["folderId"],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "added": added,
      "modified": modified,
      "type": type,
      "folderId": folderId,
    };
  }
}
