import 'package:chat_app/ui/add_room/add_room_screen.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:chat_app/ui/home/home_view_model.dart';
import 'package:chat_app/ui/home/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.readRooms();
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
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              return GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) =>
                    RoomWidget(homeViewModel.rooms[index]),
                itemCount: homeViewModel.rooms.length,
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.routeName);
              },
              child: const Icon(Icons.add)),
        ),
      ),
    );
  }
}
