import 'package:chat_app/model/room_category/room_category.dart';
import 'package:chat_app/ui/add_room/add_room_view_model.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add room screen';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  List<RoomCategory> categories = RoomCategory.getRoomCategory();
  late RoomCategory selectedRoomCategory;
  var roomDescriptionController = TextEditingController();
  var roomNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRoomCategory = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Add Room'),
            centerTitle: true,
          ),
          body: Card(
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 30,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Create New Room',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Image.asset('assets/images/room_image.png'),
                        TextFormField(
                          controller: roomNameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter room name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Center(child: Text(' Room Name')),
                          ),
                        ),
                        DropdownButton<RoomCategory>(
                            value: selectedRoomCategory,
                            items: categories.map((category) {
                              return DropdownMenuItem<RoomCategory>(
                                value: category,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/${category.imageName}',
                                        height: 46,
                                        width: 46,
                                      ),
                                    ),
                                    Text(category.name),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedRoomCategory = value;
                              });
                            }),
                        TextFormField(
                          controller: roomDescriptionController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter room description';
                            }
                            return null;
                          },
                          maxLines: 4,
                          minLines: 4,
                          decoration: InputDecoration(
                            label: Center(child: Text(' Room Descreption')),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            submit();
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              height: 40,
                              width: 22,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text(
                                  'Create',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if (formKey.currentState!.validate() == false) {
      return;
    }
    viewModel.addRoom(roomNameController.text, roomDescriptionController.text,
        selectedRoomCategory.id);
  }

  @override
  void goBack() {
    Navigator.pop(context);
  }
}
