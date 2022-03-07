import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressNullCheck extends StatelessWidget {
  final String? genderText;
  final String addressText;
  final VoidCallback createCustomer;
  const AddressNullCheck({
    Key? key,
    this.genderText,
    required this.addressText,
    required this.createCustomer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS
        ? CupertinoAlertDialog(
            title: Text(genderText ?? addressText),
            actions: [
              CupertinoDialogAction(
                child: const Text('Yes'),
                onPressed: genderText != null
                    ? null
                    : () {
                        createCustomer();
                        Navigator.of(context).pop();
                      },
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
            ],
          )
        : AlertDialog(
            title: Text(genderText ?? addressText),
            actions: [
              TextButton(
                onPressed: genderText != null
                    ? null
                    : () {
                        createCustomer();
                        Navigator.of(context).pop();
                      },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
            ],
          );
  }
}
