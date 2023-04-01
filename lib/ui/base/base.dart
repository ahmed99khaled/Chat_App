import 'dart:ui';

import 'package:flutter/material.dart';

import '../../dialog_utils.dart';

abstract class BaseNavigator {
  showProgressDialog(String message, {bool isDismissible = true});

  showMessage(
    String message, {
    bool isDismissible = true,
    String? posActionTitle,
    String? negActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
  });

  void hideDialog();
}

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
  NAV? navigator;
}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void hideDialog() {
    DialogUtils.hideDialog(context);
  }

  @override
  showMessage(String message,
      {bool isDismissible = true,
      String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction}) {
    DialogUtils.showMessage(context, message);
  }

  @override
  showProgressDialog(String message, {bool isDismissible = true}) {
    DialogUtils.showProgressDialog(context, message);
  }
}
