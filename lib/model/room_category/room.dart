class Room {
  String? id;
  String? titleRoom;
  String? descriptionRoom;
  String? categoryId;

  Room(
      {this.id,
      required this.titleRoom,
      required this.descriptionRoom,
      required this.categoryId});

  Room.fromJson(Map<String, dynamic> data)
      : this(
            id: data['id'],
            titleRoom: data['titleRoom'],
            descriptionRoom: data['descriptionRoom'],
            categoryId: data['categoryId']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleRoom': titleRoom,
      'descriptionRoom': descriptionRoom,
      'categoryId': categoryId
    };
  }
}
