import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var uniqueid = 0;
int getUniqueid() {
  uniqueid += 1;
  return uniqueid;
}

String errorMessage;
Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (error) {
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
  }
  if (errorMessage != null) {
    return Future.error(errorMessage);
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The Password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('Ther account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addJob(
    String hrname,
    String hrcontactinfo,
    String jobdetails,
    String vacancy,
    String salary,
    String joblocation,
    String partorfull) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var inputid = getUniqueid();
    String finalinputid = inputid.toString();
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('jobs').doc();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          //"Uniqueid": finalinputid,
          "User_id": uid,
          "Hr_Name": hrname,
          "Hr_Contactinfo": hrcontactinfo,
          "Job_details": jobdetails,
          "Vacancy": vacancy,
          "Salary": salary,
          "Job_location": joblocation,
          "partorfull": partorfull
        });
      }
      return true;
    });
  } catch (e) {
    print("The Data Did not get saved");
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
