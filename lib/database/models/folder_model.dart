class FolderModel {
  late int?
      id; // Not mandatory, as the id will be null when the item is first created, before insertion to database.
  late String title;
  late String added;
  late String? modified;

  FolderModel(
      {this.id, required this.title, required this.added, this.modified});

  FolderModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    added = map["added"];
    modified = map["modified"];
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "added": added, "modified": modified};
  }
}
