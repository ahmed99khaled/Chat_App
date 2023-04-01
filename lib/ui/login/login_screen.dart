import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:chat_app/ui/create_account/create_account.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/validation_utils.dart';
import 'package:chat_app/ui/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = true;
  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    super.initState();
    viewModel.userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Login '),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        width: 180,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: RiveAnimation.asset(
                          "assets/images/animated_login_character.riv",
                          stateMachines: const ["Login Machine"],
                          onInit: (artboard) {
                            controller = StateMachineController.fromArtboard(
                                artboard, "Login Machine");
                            if (controller == null) return;

                            artboard.addController(controller!);
                            isChecking = controller?.findInput("isChecking");
                            isHandsUp = controller?.findInput("isHandsUp");
                            trigSuccess = controller?.findInput("trigSuccess");
                            trigFail = controller?.findInput("trigFail");
                          },
                        ),
                      ),
                      CustomFormField('Email Address',
                          prefixIcon: const Icon(Icons.email),
                          controller: emailController, onchange: (value) {
                        if (isHandsUp != null) {
                          isHandsUp!.change(false);
                        }
                        if (isChecking == null) return;

                        isChecking!.change(true);
                      }, validator: (text) {
                        if (text!.trim() == '') {
                          return 'please Enter Email';
                        }
                        // final bool emailValid = RegExp(
                        //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(text);
                        if (ValidationUtils.isValidEmail(text) == false) {
                          return 'please Enter valid Email';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomFormField('password',
                          hideText: showPassword,
                          onchange: (value) {
                            if (isChecking != null) {
                              isChecking!.change(false);
                            }
                            if (isHandsUp == null) return;

                            isHandsUp!.change(true);
                          },
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: showPassword == true
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined)),
                          controller: passwordController,
                          validator: (text) {
                            if (text!.trim() == '') {
                              return 'please Enter Password';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size.fromHeight(40)),
                            maximumSize:
                                MaterialStatePropertyAll(Size.fromHeight(50)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13))),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.all(8),
                            ),
                          ),
                          child: Text('Login')),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, CreateAccount.routeName);
                          },
                          child: Text('Create an account')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate() == false) {
      return;
    }
    viewModel.loginFirebaseAuth(emailController.text, passwordController.text);
  }

  @override
  void goToHome() {
    Provider.of<UserProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
