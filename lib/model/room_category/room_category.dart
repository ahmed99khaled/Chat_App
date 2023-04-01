class RoomCategory {
  String id;
  String name;
  String imageName;

  RoomCategory({required this.id, required this.name, required this.imageName});

  static List<RoomCategory> getRoomCategory() {
    return [
      RoomCategory(id: 'movies', name: 'Movies', imageName: 'movies.png'),
      RoomCategory(id: 'music', name: 'Music', imageName: 'music.png'),
      RoomCategory(id: 'sports', name: 'Sports', imageName: 'sports.png'),
    ];
  }
}
