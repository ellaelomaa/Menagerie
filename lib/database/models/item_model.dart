// The base model for all different item types. Different item types have
// different attributes, but as they share all the basic ones, they
// all use the same model and just omit the attributes their type doesn't need.

class ItemModel {
  final int?
      id; // Not mandatory, as the id will be null when the item is first created, before insertion to database.
  final String title;
  final String added;
  final String? modified;
  final String type;
  final int? folderId;
  final String? content;
  final int? pinned;
  final int? checked;
  final int? parentId;
  final int? judgement;

  ItemModel(
      {this.id,
      required this.title,
      required this.added,
      this.modified,
      required this.type,
      this.folderId,
      this.content,
      this.pinned,
      this.checked,
      this.parentId,
      this.judgement});

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        title: json["title"],
        added: json["added"],
        modified: json["modified"],
        type: json["type"],
        folderId: json["folderId"],
        content: json["content"],
        pinned: json["pinned"],
        checked: json["checked"],
        parentId: json["parentId"],
        judgement: json["judgement"],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "added": added,
      "modified": modified,
      "type": type,
      "folderId": folderId,
      "content": content,
      "pinned": pinned,
      "checked": checked,
      "parentId": parentId,
      "judgement": judgement
    };
  }
}
