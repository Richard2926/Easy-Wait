
import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalData {
  GlobalData._();

  static Stream<DocumentSnapshot> userStream;
  static DocumentSnapshot user;

  static Stream<DocumentSnapshot> adminGlobalStream;
  static DocumentSnapshot adminGlobal;

  static Stream<QuerySnapshot> nearMeStream;
  static QuerySnapshot nearMe;

  static Stream<QuerySnapshot> myRoomsStream;
  static QuerySnapshot myRooms;

  static Stream<QuerySnapshot> acceptedStream;
  static QuerySnapshot accepted;

  static final version = 1.0;
  static bool verified;
  static bool active;

}
