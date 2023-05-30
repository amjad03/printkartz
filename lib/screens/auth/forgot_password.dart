
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../repository/auth_repository.dart';
import '../../services/validation_service.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool sent = false;
  bool isLoading = false;


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var bgColor = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
    // var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white;
    bool isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
    var iconColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                height: Dimensions.sixHundred,
                margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20, bottom: Dimensions.height20),
                child: sent
                ? Form(
                  key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          // SizedBox(height: Dimensions.height20,),
                          // SizedBox(
                          //   width: Dimensions.hundred,
                          //   child: Image(image: AssetImage(
                          //       Images.success
                          //   )),
                          // ),
                          SizedBox(height: Dimensions.height20,),
                          Text("We have sent you a password reset link to ${emailController.text},\ncheck your email inbox.(if not found then check your spam folder)",style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.w400,fontFamily: 'Inter'),textAlign: TextAlign.center,),
                          SizedBox(height: Dimensions.height40,),
                          // CustomInputField(controller: emailController, icon: Icons.email, label: "Enter Your Registered Email", password: false, phoneNumber: false,maxLines: 1, isFor: 'Email',),
                        //   Padding(
                        //   padding: EdgeInsets.all(Dimensions.ten),
                        //   child: TextFormField(
                        //     controller: emailController,
                        //     textAlign: TextAlign.start,
                        //     cursorColor: Colors.grey,
                        //     // obscureText: widget.password ? show : false,
                        //     keyboardType: TextInputType.text,
                        //     maxLines: 1,
                        //     decoration: InputDecoration(
                        //       focusColor: Colors.grey,
                        //       contentPadding: EdgeInsets.all(Dimensions.fifteen),
                        //       label: const Text("Enter Your Registered Email"),
                        //       prefixIcon: const Icon(
                        //         Icons.email,
                        //         color: Colors.grey,
                        //       ),
                        //       // suffixIcon: widget.password
                        //       //     ? show
                        //       //     ? IconButton(
                        //       //   icon: const Icon(
                        //       //     Icons.visibility,
                        //       //     color: Colors.grey,
                        //       //   ),
                        //       //   onPressed: () {
                        //       //     setState(() {
                        //       //       show = !show;
                        //       //     });
                        //       //   },
                        //       // )
                        //       //     : IconButton(
                        //       //   icon: const Icon(
                        //       //     Icons.visibility_off,
                        //       //     color: Colors.grey,
                        //       //   ),
                        //       //   onPressed: () {
                        //       //     setState(() {
                        //       //       show = !show;
                        //       //     });
                        //       //   },
                        //       // )
                        //       //     : null,
                        //       border: const OutlineInputBorder(),
                        //       iconColor: iconColor,
                        //       labelStyle: TextStyle(color: iconColor),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(width: 2, color: iconColor),
                        //       ),
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || !isEmail(value)) {
                        //         return "Please enter a valid email address";
                        //       } else {
                        //         return null;
                        //       }
                        //     },
                        //   ),
                        // ),
                        //   SizedBox(height: Dimensions.height20,),
                          CustomButton(title: "OK", onPressed: () {
                            setState(() {
                              sent = !sent;
                            });
                            Navigator.of(context).pop();
                          },),

                      ],
                    ),
                  )
                : Form(
                  key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image(image: isDark
                        //     ? AssetImage(Images.forgotPassImageDark)
                        //     : AssetImage(Images.forgotPassImageLight)
                        // ),
                        Text(Strings.forgotPass,style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.w400,fontFamily: 'Inter'),),
                        SizedBox(height: Dimensions.height20,),
                        Divider(indent: Dimensions.forty, endIndent: Dimensions.forty,),
                        SizedBox(height: Dimensions.height20,),
                        Text("Don’t Worry Write Your Registered email below",style: TextStyle(fontSize: Dimensions.fifteen,fontWeight: FontWeight.w400,fontFamily: 'Inter'),textAlign: TextAlign.center,),
                        SizedBox(height: Dimensions.height20,),
                        // CustomInputField(controller: emailController, icon: Icons.email, label: "Enter Your Registered Email", password: false, phoneNumber: false,maxLines: 1, isFor: 'Email',),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.ten),
                          child: TextFormField(
                            controller: emailController,
                            textAlign: TextAlign.start,
                            cursorColor: Colors.grey,
                            // obscureText: widget.password ? show : false,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            decoration: InputDecoration(
                              focusColor: Colors.grey,
                              contentPadding: EdgeInsets.all(Dimensions.fifteen),
                              label: const Text("Enter Your Registered Email"),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              // suffixIcon: widget.password
                              //     ? show
                              //     ? IconButton(
                              //   icon: const Icon(
                              //     Icons.visibility,
                              //     color: Colors.grey,
                              //   ),
                              //   onPressed: () {
                              //     setState(() {
                              //       show = !show;
                              //     });
                              //   },
                              // )
                              //     : IconButton(
                              //   icon: const Icon(
                              //     Icons.visibility_off,
                              //     color: Colors.grey,
                              //   ),
                              //   onPressed: () {
                              //     setState(() {
                              //       show = !show;
                              //     });
                              //   },
                              // )
                              //     : null,
                              border: const OutlineInputBorder(),
                              iconColor: iconColor,
                              labelStyle: TextStyle(color: iconColor),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: iconColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || !isEmail(value)) {
                                return "Please enter a valid email address";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        CustomButton(title: "Send Reset Link", onPressed: () {
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              sent = !sent;
                            });
                            setState(() {
                              isLoading = true;
                            });
                            sendResetPasswordLink(emailController.text.trim());
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },),

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

  // bool isEmail(String value) {
  //   // Use regex to validate email format
  //   return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  // }
}


