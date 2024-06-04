// Can be a list or a tarot hand

class ParentModel {
  final int? id;
  final String title;
  final String added;
  final String? modified;
  final String type;
  final int folderId;
  final int? pinned;

  ParentModel({
    this.id,
    required this.title,
    required this.added,
    this.modified,
    required this.type,
    required this.folderId,
    this.pinned,
  });

  factory ParentModel.fromMap(Map<String, dynamic> json) => ParentModel(
        id: json["id"],
        title: json["title"],
        added: json["added"],
        modified: json["modified"],
        type: json["type"],
        folderId: json["folderId"],
        pinned: json["pinned"],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "added": added,
      "modified": modified,
      "type": type,
      "folderId": folderId,
      "pinned": pinned,
    };
  }
}
