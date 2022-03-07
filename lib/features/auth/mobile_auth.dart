import 'package:chopper/chopper.dart';
import 'package:erg/api/auth/auth_api.dart';
import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _usernameController =
      TextEditingController(text: appStateManager.user);
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
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
        await Provider.of<ErgAuthService>(context, listen: false)
            .managerLoggingIn(
                _usernameController.text, _passwordController.text);
    if (returnResult.error is CustomError) {
      errorSnackBar(returnResult.error.toString(), context);
    }
    if (returnResult.isSuccessful) {
      Provider.of<AppStateManager>(context, listen: false).login(
        tokenPayload: returnResult.body!,
        username: _usernameController.text,
      );
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
