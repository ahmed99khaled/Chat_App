import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/room_category/room.dart';

class MyDatabase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
          fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance.collection('rooms').withConverter<Room>(
          fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
          toFirestore: (room, _) => room.toJson(),
        );
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomCollection()
        .doc(roomId)
        .collection('messages')
        .withConverter<Message>(
          fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        );
  }

  static Future<MyUser> insertUser(MyUser user) async {
    var usersCollection = getUserCollection();
    var res = await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<MyUser?> getUser(String userId) async {
    var usersCollection = getUserCollection();
    var docRef = usersCollection.doc(userId);
    var res = await docRef.get();
    return res.data();
  }

  static Future<void> createRoom(Room room) async {
    var roomCollection = getRoomCollection();
    var docRef = roomCollection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> getRooms() async {
    var snapRooms = await getRoomCollection().get();
    return snapRooms.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> addMessage(Message message) {
    var messageCollection = getMessageCollection(message.roomId ?? '');
    var docRef = messageCollection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessage(String roomId) {
    return getMessageCollection(roomId).orderBy('dateTime').snapshots();
  }
}
