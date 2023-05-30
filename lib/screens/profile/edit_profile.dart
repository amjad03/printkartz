
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Printzkart/repository/auth_repository.dart';
import '../../constants/dimensions.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;

    Future<void> editName(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Your New Name'),
            content: TextFormField(
              controller: nameController,
              textAlign: TextAlign.start,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                    )
                ),
                focusColor: Colors.grey,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                    )
                )
              ),
            ),
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
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      updateName(nameController.text);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    Future<void> editEmail(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Your New Email'),
            content: TextFormField(
              controller: emailController,
              textAlign: TextAlign.start,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1
                      )
                  ),
                  focusColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1
                      )
                  )
              ),
            ),
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
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      updateEmail(emailController.text);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    Future<void> editPhone(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Your New Phone Number'),
            content: TextFormField(
              controller: phoneController,
              textAlign: TextAlign.start,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1
                      )
                  ),
                  focusColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.grey,
                      width: 1
                  )
                )
              ),
            ),
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
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      updatePhone(phoneController.text);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    Future<void> editPassword(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Your New Password'),
            content: TextFormField(
              controller: passwordController,
              textAlign: TextAlign.start,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1
                      )
                  ),
                focusColor: Colors.grey,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1
                  )
                )
              ),
            ),
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
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      updatePassword(passwordController.text);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Edit Profile",style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            // width: double.maxFinite,
            margin: EdgeInsets.all(Dimensions.fifteen),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Name : ",style: TextStyle(fontSize: Dimensions.twenty),),
                    Text(currentUser?.displayName ?? '',style: TextStyle(fontSize: Dimensions.twenty),overflow: TextOverflow.ellipsis,),
                    IconButton(onPressed: () {
                      editName(context);
                    },
                        icon: const Icon(Icons.edit)
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Email : ",style: TextStyle(fontSize: Dimensions.twenty),),
                    SizedBox(
                      width: Dimensions.twoHundred,
                        child: Text(currentUser?.email ?? '',style: TextStyle(fontSize: Dimensions.twenty,),overflow: TextOverflow.ellipsis,)),
                    IconButton(onPressed: () {
                      editEmail(context);
                    },
                        icon: const Icon(Icons.edit)
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Phone : ",style: TextStyle(fontSize: Dimensions.twenty),),
                    Text(currentUser?.phoneNumber ?? '-',style: TextStyle(fontSize: Dimensions.twenty),overflow: TextOverflow.ellipsis,),
                    IconButton(
                        onPressed: () {
                          editPhone(context);
                        },
                        icon: const Icon(Icons.edit)
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Password : ",style: TextStyle(fontSize: Dimensions.twenty),),
                    Text('**********',style: TextStyle(fontSize: Dimensions.twenty),overflow: TextOverflow.ellipsis,),
                    IconButton(
                        onPressed: () {
                          editPassword(context);
                        },
                        icon: const Icon(Icons.edit)
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customRoundedButton('Cancel', Icons.cancel, onPressed: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),

              ],
            ),
          ),
          if (isLoading)
            const Opacity(
              opacity: 0.4,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ]
      ),
    );
  }
}


