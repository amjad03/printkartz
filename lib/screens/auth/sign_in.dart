
import 'package:flutter/material.dart';
import 'package:Printzkart/repository/auth_repository.dart';
import 'package:Printzkart/screens/auth/forgot_password.dart';
import 'package:Printzkart/screens/auth/sign_up.dart';
import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../services/validation_service.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool show = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var bgColor = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white;
    // var color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white;
    bool isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
    var iconColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45;

    return Scaffold(
      backgroundColor: bgColor,
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                height: Dimensions.sixHundred,
                margin: EdgeInsets.all(Dimensions.height20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Strings.welcome,style: TextStyle(fontSize: Dimensions.thirty,fontWeight: FontWeight.w500,fontFamily: 'Inter'),),
                      // Image(image: isDark
                      //     ? AssetImage(Images.signInDark)
                      //     : AssetImage(Images.signInLight)
                      // ),
                      SizedBox(height: Dimensions.height20,),
                      Divider(indent: Dimensions.forty, endIndent: Dimensions.forty,),
                      SizedBox(height: Dimensions.height20,),
                      Text(Strings.login,style: TextStyle(fontSize: Dimensions.twenty,fontWeight: FontWeight.w400,fontFamily: 'Inter'),),
                      SizedBox(height: Dimensions.height20,),
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
                      SizedBox(height: Dimensions.height10,),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                            },
                            child: Text(Strings.forgotPass,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.blue,fontFamily: 'Inter'),)),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      CustomButton(title: "Sign In",onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          String? res = await signInWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());
                          if(res == 'true'){
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
                          Text(Strings.notHaveAccount,style: TextStyle(fontSize: Dimensions.fifteen,color: AppColors.grey,fontFamily: 'Inter'),),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                              },
                              child: Text(Strings.signUp,style: TextStyle(fontSize: Dimensions.fifteen,color: Colors.blue,fontFamily: 'Inter'),)),
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
    Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
  }

  void snackBar(String res){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}


