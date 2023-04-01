import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateAccountNavigator extends BaseNavigator {
  goToHome();
}

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  late UserProvider userProvider;

  createAccountFirebaseAuth(
      String email, String password, String firstName, String lastName) async {
    navigator?.showProgressDialog('loading...');
    try {
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser user = MyUser(
          id: credential.user!.uid,
          firstName: firstName,
          lastName: lastName,
          email: email);
      var userInserted = await MyDatabase.insertUser(user);
      navigator?.hideDialog();
      if (userInserted != null) {
        userProvider.saveUserId(userInserted);
        navigator?.goToHome();
      } else {
        navigator?.showMessage('something went wrong with database ');
      }
      //navigator?.hideDialog();
      //navigator?.showMessage(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      navigator?.hideDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      navigator?.hideDialog();
      navigator?.showMessage('something wrong,try again');
    }
  }
}
