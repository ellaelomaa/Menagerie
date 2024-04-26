class FolderVanha {
  final int? id;
  final String title;
  final String added;

  FolderVanha({this.id, required this.title, required this.added});

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "added": added};
  }

  factory FolderVanha.fromMap(Map<String, dynamic> map) {
    return FolderVanha(
        id: map["id"]?.toInt() ?? 0,
        title: map["title"] ?? "",
        added: map["added"] ?? "");
  }

  // Used for testing purposes only
  @override
  String toString() => "Folder(id: $id, title: $title, added: $added)";
}
