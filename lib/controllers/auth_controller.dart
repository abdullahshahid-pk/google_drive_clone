import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user.bindStream(auth.authStateChanges());
  }

  signUp()async{
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser != null){
      GoogleSignInAuthentication  googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      userCollection.doc(user!.uid).set({
        'userName': user.displayName,
        'profilePic': user.photoURL,
        'userEmail': user.email,
        'userIdentity': user.uid,
        'userCreated': DateTime.now(),
      });
    }
    else{
      print('account not exist');
      Get.snackbar('No Account', 'You did not have a google account');
    }
  }
}