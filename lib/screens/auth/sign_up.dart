
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printzkart/widgets/custom_input.dart';
import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../repository/auth_repository.dart';
import '../../services/validation_service.dart';
import '../../widgets/custom_button.dart';

String gender = '';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool show = true;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var bgColor = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
    // var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white;
    bool isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
    var iconColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                // height: Dimensions.sixHundred,
                margin: EdgeInsets.all(Dimensions.height20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Strings.create,style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.w500,fontFamily: 'Inter'),),
                      SizedBox(height: Dimensions.height20,),
                      // SizedBox(
                      //   width: Dimensions.threeHundred,
                      //   child: Image(image: isDark
                      //       ? AssetImage(Images.signupDark)
                      //       : AssetImage(Images.signupLight)
                      //   ),
                      // ),
                      Divider(indent: Dimensions.forty, endIndent: Dimensions.forty,),
                      SizedBox(height: Dimensions.height20,),
                      // CustomInputField(controller: nameController, icon: Icons.person, label: "Enter Your Name", password: false, phoneNumber: false,maxLines: 1, isFor: 'Name',),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.ten),
                        child: TextFormField(
                          controller: nameController,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            contentPadding: EdgeInsets.all(Dimensions.fifteen),
                            label: const Text("Enter Your Name"),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            iconColor: iconColor,
                            labelStyle: TextStyle(color: iconColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: iconColor),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Name is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      // CustomInputField(controller: phoneController, icon: Icons.call, label: "Enter Your Phone", password: false, phoneNumber: true,maxLines: 1, isFor: 'Phone',),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.ten),
                        child: TextFormField(
                          controller: phoneController,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          maxLength: 10,
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            contentPadding: EdgeInsets.all(Dimensions.fifteen),
                            label: const Text("Enter Your Phone"),
                            prefixIcon: const Icon(
                              Icons.call,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            iconColor: iconColor,
                            labelStyle: TextStyle(color: iconColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: iconColor),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Phone Number is required";
                            }
                            else if (value.length < 10) {
                              return "Phone number must be 10 digits";
                            }
                            else if (!value.isNumericOnly) {
                              return "Please enter a valid phone number";
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      const DropDown(),
                      SizedBox(height: Dimensions.height10,),
                      // CustomInputField(controller: emailController, icon: Icons.email, label: "Enter Your Email", password: false, phoneNumber: false,maxLines: 1, isFor: 'Email',),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.ten),
                        child: TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            contentPadding: EdgeInsets.all(Dimensions.fifteen),
                            label: const Text("Enter Your Email"),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            iconColor: iconColor,
                            labelStyle: TextStyle(color: iconColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: iconColor),
                            ),
                          ),
                          validator: (value) {
                            if(value == null){
                              return "Email is required";
                            }
                            else if (!isEmail(value)) {
                              return "Please enter a valid email address";
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      // CustomInputField(controller: passwordController, icon: Icons.lock, label: "Enter Your Password", password: true, phoneNumber: false,maxLines: 1, isFor: 'Password',),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.ten),
                        child: TextFormField(
                          controller: passwordController,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.grey,
                          obscureText: show,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            contentPadding: EdgeInsets.all(Dimensions.fifteen),
                            label: const Text("Enter Your Password"),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: show
                                ? IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                            )
                                : IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                            iconColor: iconColor,
                            labelStyle: TextStyle(color: iconColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: iconColor),
                            ),
                          ),
                          validator: (value) {
                            if(value == null){
                              return "Password is required";
                            }
                            else if (value.length < 8) {
                              return "Password must be at least 8 characters";
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      CustomButton(title: "Sign Up",onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          String? res = await signUpWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim(), nameController.text.trim(), context);
                          if(res == 'true'){
                            addUserData(nameController.text.trim(), emailController.text.trim(), gender ,phoneController.text.trim());
                            moveToHomePage();
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }),
                      SizedBox(height: Dimensions.height20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Strings.alreadyHaveAccount,style: TextStyle(fontSize: Dimensions.fifteen,color: AppColors.grey,fontFamily: 'Inter'),),
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Text(Strings.signIn,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.blue,fontFamily: 'Inter'),)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            const Opacity(
              opacity: 0.4,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ]

      ),
    );
  }

  void moveToHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
  }

  void snackBar(res){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res as String),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  _DropDownState() {
    gender = genderList[0];
  }

  // String gender = '';
  List genderList = ['Male', 'Female', 'Other'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.ten),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey,width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.radius5)
        ),
        child: DropdownButtonFormField(
          value: gender,
          hint: const Text('Select Gender',style: TextStyle(fontFamily: 'Inter'),),
          onChanged: (value) {
            setState(() {
              gender = value!;
            });
          },
          items: genderList.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(e,style: const TextStyle(fontFamily: 'Inter'),),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.male,color: Colors.grey,),
          ),

        ),
      ),
    );
  }
}

