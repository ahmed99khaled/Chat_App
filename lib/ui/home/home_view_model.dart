import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/ui/base/base.dart';

import '../../model/room_category/room.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void readRooms() async {
    rooms = await MyDatabase.getRooms();
  }
}
