import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/validation_utils.dart';
import 'package:chat_app/ui/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_account_viewModel.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = 'create account';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState
    extends BaseView<CreateAccount, CreateAccountViewModel>
    implements CreateAccountNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fistNameController = TextEditingController();
  var lastNameController = TextEditingController();
  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    viewModel.userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
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
            title: Text('Create Account '),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFormField(controller: fistNameController, 'First Name',
                      validator: (text) {
                    if (text!.trim() == '') {
                      return 'please Enter first name';
                    }
                    return null;
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  CustomFormField(controller: lastNameController, 'Last Name',
                      validator: (text) {
                    if (text!.trim() == '') {
                      return 'please Enter last name';
                    }
                    return null;
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  CustomFormField('Email Address', controller: emailController,
                      validator: (text) {
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
                  SizedBox(
                    height: 8,
                  ),
                  CustomFormField('password',
                      hideText: showPassword,
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: showPassword == true
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined)),
                      controller: passwordController, validator: (text) {
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
                        createAccount();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(8),
                        ),
                      ),
                      child: Text('Create Account')),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: Text('Already have an account?')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    if (formKey.currentState!.validate()) {
      await viewModel.createAccountFirebaseAuth(
          emailController.text,
          passwordController.text,
          fistNameController.text,
          lastNameController.text);
    }
  }

  @override
  void goToHome() {
    Provider.of<UserProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
