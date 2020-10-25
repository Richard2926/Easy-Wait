import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wait/misc/globaldata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yorubanames/yorubanames.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Stream<FirebaseUser> user;
  Stream<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();
  //StreamSubscription<DocumentSnapshot> subscription;
  //Geoflutterfire geo = Geoflutterfire();

  StorageUploadTask _uploadTask;

  // constructor
  AuthService() {
    user = _auth.onAuthStateChanged;

//    profile = user.switchMap((FirebaseUser u) {
//      if (u != null) {
//        return _db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
//      } else {
//        return Stream.value({});
//      }
//    });
  }

  Future<void> signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      //return e.toString();
      return null;
    }
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.updateData({
      'lastSeen': DateTime.now(),
    });
  }
  Future<String> googleSignIn() async {
    print("Signing in using Google");
    try {
      //loading.add(true);

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      updateUserData(user);
      print("User Name: ${user.displayName}");

      //loading.add(false);
      return user.uid;
    } catch (error) {
      print(error);
      //return error;
      return null;
    }
  }
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    updateUserData(user);
    //print(user.uid);
    return user.uid;
  }

  String randomName() {

    final yGenerator  generator = new yGenerator();

    List names= generator.randomYname(1);

    return names[0];

  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    createClient(user);
    return user.uid;
  }

  Future<List> isUpToDate() async {
    var data;
    var query = _db.collection('users').where('UserType', isEqualTo: 'Admin').getDocuments();
    var version = 1;
    var max;
    await query.then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        data = docs.documents[0].data;
        max = docs.documents[0]['version'];
      } else {
        max = version;
      }
    });

    return [(max == version), data];
  }
  Stream<DocumentSnapshot> userStream(String uid) {
    print("Getting user stream: $uid");
    return _db.collection('users').document(uid).snapshots();
  }
  Stream<DocumentSnapshot> adminGlobal() {
    print("Retrieving admin stream");
    return _db.collection('admin').document("Global Data").snapshots();
  }
  Stream<QuerySnapshot> getAccepted(String uid) {
    print("Retrieving done rooms");
    return _db.collectionGroup('rooms').where("done", arrayContains: uid).snapshots();
  }
  Stream<QuerySnapshot> getMyRooms(String uid) {
    print("Retrieving my rooms");
    return _db.collectionGroup('rooms').where("queue", arrayContains: uid).snapshots();
  }

  void createClient(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    //String name = randomName();
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'created': DateTime.now(),
      'lastSeen': DateTime.now(),
    }, merge: true);
  }

  Future<bool> addRoom(String key) async{
    bool result;
    var query = _db.collectionGroup('rooms').where('key', isEqualTo: key).getDocuments();
    await query.then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {

        Map data = docs.documents[0].data;
        print(key);

        if(data['queue'].contains(GlobalData.user['uid'])){
          result =  false;
        } else {
          DocumentReference ref = _db.collection('enablers').document(data['enablerId'])
              .collection("rooms").document(data['id']);
          //String name = randomName();
          ref.updateData({
            'queue': FieldValue.arrayUnion([GlobalData.user['uid']])
          });
          result = true;
        }

      } else {
        result = false;
      }
    });
    return result;
  }
  void setUserActive(bool active, String uid) async {
    //print(active);
    DocumentReference ref = _db.collection('users').document(uid);

    return ref.setData({
      'active' : active
    }, merge: true);
  }
  Future<String> currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user?.uid;
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {

    FirebaseUser user = await _auth.currentUser();
    await user.reload();
    await user.reload();
    //print(user.isEmailVerified);
    return user.isEmailVerified;

  }

  // Future<Map> getData() async {
  //   final FirebaseUser user = await _auth.currentUser();
  //   var data;
  //   DocumentReference documentReference = _db.collection('users').document(user.uid);
  //   await documentReference.get().then((value) => {
  //         data = value.data,
  //       });
  //   print("Auth Get User Data Checkpoint");
  //   return data;
  // }

}

final AuthService authService = new AuthService();
