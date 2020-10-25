import firebase from "firebase/app";
import "firebase/auth";
import "firebase/firebase-firestore";
import firebaseConfig from "./firebaseConfig";

class FirebaseAuthService {
  auth;
  firestore;
  //   database;
  //   storage;

  googleProvider;
  facebookProvider;
  twitterProvider;

  constructor() {
    // UNCOMMENT IF YOU WANT TO USE FIREBASE

    this.init();
    this.auth = firebase.auth();
    this.firestore = firebase.firestore();

    //   this.database  = firebase.database();
    //   this.storage = firebase.storage();
    
    // this.googleProvider = new firebase.auth.GoogleAuthProvider();
    // this.facebookProvider = new firebase.auth.FacebookAuthProvider();
    // this.twitterProvider = new firebase.auth.TwitterAuthProvider();
  }

  init = () => {
    firebase.initializeApp(firebaseConfig);
  };

  checkAuthStatus = callback => {
    this.auth.onAuthStateChanged(callback);
  };

  signUpWithEmailAndPassword = (email, password) => {
    return this.auth.createUserWithEmailAndPassword(email, password);
  };

  signInWithEmailAndPassword = async (email, password) => {
    
    //console.log("Checlpoint1");
    let userDataSetOne = await this.auth.signInWithEmailAndPassword(email, password);
    let userDataSetTwo = await this.getUserData();
    //console.log("Checlpoint4");
    return [...userDataSetOne, ...userDataSetTwo];
  };

  signInWithPopup = media => {
    switch (media) {
      case "google":
        return this.auth.signInWithPopup(this.googleProvider);

      case "facebook":
        return this.auth.signInWithPopup(this.facebookProvider);

      case "twitter":
        return this.auth.signInWithPopup(this.twitterProvider);

      default:
        break;
    }
  };

  signInWithPhoneNumber = phoneNumber => {
    return this.auth.signInWithPhoneNumber(phoneNumber);
  };
  moveUser = async(uid, queue) => {
    console.log(queue);
    if(queue){
      await this.firestore
      .collection("users")
      .doc(uid)
      .update({
        queue: firebase.firestore.FieldValue.arrayRemove(uid),
        done: firebase.firestore.FieldValue.arrayUnion(uid)
      })
    }else{
      await this.firestore
      .collection("users")
      .doc(uid)
      .update({
        done: firebase.firestore.FieldValue.arrayUnion(uid)
      })
    }
    return;
  }
  getUserData = async () => {
    //console.log("Checlpoint2");
    //   generally it's better to use uid for docId
    let userData = await this.firestore
      .collection("users")
      .doc(this.auth.currentUser.uid)
      .get();
    //console.log("Checlpoint3");
    let result = userData.data()
    return result;
  };
  getUsersData = async (users) => {
    console.log(users);
    let userData = [];
    await users.forEach( async (user) => {
      if(user != ""){
      let data = await this.firestore
          .collection("users")
          .doc(user)
          .get();

        userData.push(data.data())
      }
    })
    return userData
  }
  getDashboardData = async (uid) => {
    let dashBoardData = {};
    let roomData = [];
    let queueData = [];
    let doneData = [];

    let userData = await this.getUserData();
    console.log(userData.enablerId)

    let rooms = await this.firestore
    .collection("enablers")
    .doc(userData.enablerId)
    .collection("rooms")
    .get();

    
      rooms.forEach(doc =>{
        roomData.push(doc.data());

        // doc.data().queue.forEach(user => {
        // this.firestore
        //   .collection("users")
        //   .doc(user)
        //   .get()
        //   .then((data) => {
        //     console.log(data)
        //   });

        //   //queueData.push(data.data());

        // });
      });

    console.log(roomData)

    dashBoardData.rooms = roomData;

    return dashBoardData;
  }
  getAllUser = () => {
    this.firestore
      .collection("users")
      .get()
      .then(docList => {
        docList.forEach(doc => {
          console.log(doc.data());
        });
      });
  };

  signOut = () => {
    return this.auth.signOut();
  };
}

const instance = new FirebaseAuthService();

export default instance;
