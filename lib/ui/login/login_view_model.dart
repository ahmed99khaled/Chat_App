import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  late UserProvider userProvider;

  loginFirebaseAuth(String email, String password) async {
    try {
      // show loading
      navigator?.showProgressDialog('Loading....');
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var retrievedUser = await MyDatabase.getUser(credential.user!.uid);
      navigator?.hideDialog();
      if (retrievedUser != null) {
        userProvider.saveUserId(retrievedUser);
        navigator?.goToHome();
      } else {
        navigator?.showMessage('something went wrong with database');
      }
      // show message with user id
      //navigator?.showMessage(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      navigator?.hideDialog();
      navigator?.showMessage('Wrong user name or password');
    } catch (e) {
      navigator?.hideDialog();
      navigator?.showMessage('Wrong user name or password');
    }
  }
}
