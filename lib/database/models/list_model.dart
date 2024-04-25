class ListModel {
  final int? id;
  final String name;
  final int folderId;
  final String added;
  final String? modified;

  ListModel(
      {this.id,
      required this.name,
      required this.folderId,
      required this.added,
      this.modified});

  factory ListModel.fromMap(Map<String, dynamic> json) => ListModel(
      id: json["id"],
      name: json["name"],
      folderId: json["folderId"],
      added: json["added"],
      modified: json["modified"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "folderId": folderId,
      "added": added,
      "modified": modified
    };
  }
}
