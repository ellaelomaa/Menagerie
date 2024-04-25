class Folder {
  final int?
      id; // Not mandatory, as the id will be null when the item is first created, before insertion to database.
  final String name;
  final String added;
  final String? modified;

  Folder({this.id, required this.name, required this.added, this.modified});

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
      id: json["id"],
      name: json["name"],
      added: json["added"],
      modified: json["modified"]);

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "added": added, "modified": modified};
  }
}
