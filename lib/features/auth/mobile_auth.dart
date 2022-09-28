import 'package:chopper/chopper.dart';
import 'package:erg/api/auth/auth_api.dart';
import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/listener_manager.dart';
import '../shared/models/auth/auth_model.dart';
import '../shared/models/error_model/error_model.dart';
import '../shared/widget/custom_text_field.dart';
import '../shared/widget/error_snack_bar.dart';

class MobileAuth extends StatefulWidget {
  const MobileAuth({Key? key}) : super(key: key);

  @override
  _MobileAuthState createState() => _MobileAuthState();
}

class _MobileAuthState extends State<MobileAuth>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? _user;
  late TextEditingController _usernameController;
  late ListenerManager _manager;
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _manager = Provider.of<ListenerManager>(context, listen: false);
    _user = _manager.listenerName;
    _usernameController = TextEditingController(text: _user ?? '');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _usernameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  getLogoPath(),
                  height: 300,
                  width: 300,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.8,
                child: CustomTextField(
                  controller: _usernameController,
                  hintText: 'username',
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.8,
                child: _passwordText(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitHandler(String? value) async {
    Response<AccessTokenBearer> returnResult =
        await ErgAuthService.create().managerLoggingIn(
      _usernameController.text,
      _passwordController.text,
    );
    if (returnResult.error is CustomError) {
      errorSnackBar(returnResult.error.toString(), context);
    }
    if (returnResult.isSuccessful) {
      final doneSaving = await _manager.setUserData(
        name: _usernameController.text,
        token: returnResult.body!,
      );
      if (doneSaving) {
        Provider.of<AppStateManager>(context, listen: false).login();
      }
    }
  }

  TextField _passwordText() {
    return TextField(
      onSubmitted: submitHandler,
      obscureText: isPasswordVisible,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'password',
        suffixIcon: _passwordController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () => setState(() {
                  isPasswordVisible = !isPasswordVisible;
                }),
              ),
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
