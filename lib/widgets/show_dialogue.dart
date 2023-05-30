import 'package:flutter/material.dart';
import '../repository/auth_repository.dart';

Future<void> logOutDialogBox(BuildContext context, goToMainPage) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to logout ?'),
        content: const Text("You have to login again in order to use the app's features",textAlign: TextAlign.center,),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('Cancel',style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm',style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  logOut();
                  Navigator.of(context).pop();
                  goToMainPage;
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}