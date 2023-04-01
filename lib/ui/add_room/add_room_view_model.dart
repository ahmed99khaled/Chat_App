import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/room_category/room.dart';
import 'package:chat_app/ui/base/base.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  void goBack();
}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String roomName, String roomDescription, String catId) async {
    navigator?.showProgressDialog('Create Room...');
    try {
      Room room = Room(
          titleRoom: roomName,
          descriptionRoom: roomDescription,
          categoryId: catId);
      await MyDatabase.createRoom(room);
      navigator?.hideDialog();
      navigator?.showMessage('Room Created Successfully', posActionTitle: 'OK',
          posAction: () {
        navigator?.goBack();
      }, isDismissible: false);
    } catch (e) {
      navigator?.hideDialog();
      navigator?.showMessage('something wrong,try again');
    }
  }
}
