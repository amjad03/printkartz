import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';
import '../../main.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _textAnimation;
//   final List<String> _texts = ['models', 'printers', 'filaments'];
//   int _currentTextIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//     Future.delayed(const Duration(seconds: 3), () =>
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LandingPage()
//         ),
//     ));
//   }
//
//   void _startAnimation() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 2500),
//     );
//
//     _logoAnimation = Tween<double>(
//       begin: 0.0,
//       end: 200.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.0, 0.8, curve: Curves.easeInOut),
//       ),
//     );
//
//     _textAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
//       ),
//     );
//
//     _controller.forward();
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Future.delayed(Duration(milliseconds: 500), () {
//           setState(() {
//             _currentTextIndex++;
//             if (_currentTextIndex >= _texts.length) {
//               _currentTextIndex = 0;
//             }
//           });
//           _controller.reverse();
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           // color: Colors.white, // Customize the background color if needed
//         ),
//         child: Stack(
//           // alignment: Alignment.bottomCenter,
//           fit: StackFit.expand,
//           children: [
//             AnimatedBuilder(
//               animation: _logoAnimation,
//               builder: (context, child) {
//                 return Container(
//                   height: _logoAnimation.value,
//                   child: Image.asset('assets/images/printzkart_logo.png'), // Replace with your logo asset path
//                 );
//               },
//             ),
//             Positioned(
//               bottom: 50.0,
//               child: Row(
//                 children: [
//                   const Text(
//                     "Loading ",
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                   AnimatedBuilder(
//                     animation: _textAnimation,
//                     builder: (context, child) {
//                       return Opacity(
//                         opacity: _textAnimation.value,
//                         child: Transform.translate(
//                           offset: Offset(0.0, -30.0 * _textAnimation.value),
//                           child: Text(
//                             _texts[_currentTextIndex],
//                             style: const TextStyle(fontSize: 20.0),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _textAnimation;
//   final List<String> _texts = ['models', 'printers', 'filaments'];
//   int _currentTextIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//     Future.delayed(const Duration(seconds: 3), () =>
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const LandingPage())
//         ),
//     );
//   }
//
//   void _startAnimation() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 2500),
//     );
//
//     _logoAnimation = Tween<double>(
//       begin: 0.0,
//       end: 200.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
//       ),
//     );
//
//     _textAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
//       ),
//     );
//
//     _controller.forward();
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Future.delayed(Duration(milliseconds: 500), () {
//           setState(() {
//             _currentTextIndex++;
//             if (_currentTextIndex >= _texts.length) {
//               _currentTextIndex = 0;
//             }
//           });
//           _controller.reverse();
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           // color: Colors.white, // Customize the background color if needed
//         ),
//         child: Stack(
//           // alignment: Alignment.bottomCenter,
//           fit: StackFit.expand,
//           children: [
//             // AnimatedBuilder(
//             //   animation: _logoAnimation,
//             //   builder: (context, child) {
//             //     return Positioned(
//             //       top: 100.0 - _logoAnimation.value,
//             //       left: 0.0,
//             //       right: 0.0,
//             //       child: Opacity(
//             //         opacity: 1.0 - _logoAnimation.value / 200.0,
//             //         child: Image.asset('assets/images/printzkart_logo.png'), // Replace with your logo asset path
//             //       ),
//             //     );
//             //   },
//             // ),
//             Image.asset('assets/images/printzkart_logo.png'),
//             Positioned(
//               bottom: 50.0,
//               left: 0.0,
//               right: 0.0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Loading ",
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                   AnimatedBuilder(
//                     animation: _textAnimation,
//                     builder: (context, child) {
//                       return Opacity(
//                         opacity: _textAnimation.value,
//                         child: Transform.translate(
//                           offset: Offset(0.0, 30.0 * _textAnimation.value),
//                           child: Text(
//                             _texts[_currentTextIndex],
//                             style: const TextStyle(fontSize: 20.0),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _textAnimation;
//   final List<String> _texts = ['models', 'printers', 'filaments'];
//   int _currentTextIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//     Future.delayed(const Duration(seconds: 3), () =>
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const LandingPage())
//         ),
//     );
//   }
//
//   void _startAnimation() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 3000),
//     );
//
//     _logoAnimation = Tween<double>(
//       begin: 0.0,
//       end: 200.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.0, 0.8, curve: Curves.easeInOut),
//       ),
//     );
//
//     _textAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.6, 1.0, curve: Curves.easeInOut), // Adjust the curve and interval for desired effect
//       ),
//     );
//
//     _controller.forward();
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Future.delayed(Duration(milliseconds: 500), () {
//           setState(() {
//             _currentTextIndex++;
//             if (_currentTextIndex >= _texts.length) {
//               _currentTextIndex = 0;
//             }
//           });
//           _controller.reset();
//           _controller.forward();
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           // color: Colors.white, // Customize the background color if needed
//         ),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             AnimatedBuilder(
//               animation: _logoAnimation,
//               builder: (context, child) {
//                 return Positioned(
//                   top: 100.0 - _logoAnimation.value,
//                   left: 0.0,
//                   right: 0.0,
//                   child: Opacity(
//                     opacity: 1.0 - _logoAnimation.value / 200.0,
//                     child: Image.asset('assets/images/printzkart_logo.png'), // Replace with your logo asset path
//                   ),
//                 );
//               },
//             ),
//             Positioned(
//               bottom: 50.0,
//               left: 0.0,
//               right: 0.0,
//               child: AnimatedBuilder(
//                 animation: _textAnimation,
//                 builder: (context, child) {
//                   final animatedTextIndex = (_currentTextIndex + 1) % _texts.length;
//                   final opacity = _currentTextIndex >= _texts.length ? 1.0 : _textAnimation.value;
//                   final translateY = _currentTextIndex >= _texts.length ? 0.0 : 30.0 * _textAnimation.value;
//
//                   return Transform.translate(
//                     offset: Offset(0.0, translateY),
//                     child: Opacity(
//                       opacity: opacity,
//                       child: Text(
//                         _texts[animatedTextIndex],
//                         style: const TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _boxAnimation;
  late Animation<double> _textAnimation;
  final List<String> _texts = ['Loading models', 'Loading printers', 'Loading filaments'];
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    // Future.delayed(const Duration(seconds: 3), () =>
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => const LandingPage())
    //     ),
    // );
  }

  void _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    _boxAnimation = Tween<double>(
      begin: -300.0,
      end: -500.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _textAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.easeOut), // Adjust the curve and interval for desired effect
      ),
    );

    _controller.forward();

    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     Future.delayed(Duration(milliseconds: 500), () {
    //       setState(() {
    //         _currentTextIndex++;
    //         if (_currentTextIndex >= _texts.length) {
    //           _currentTextIndex = 0;
    //         }
    //       });
    //       _controller.reset();
    //       // _controller.forward();
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade500 : Colors.white;
    // print(_boxAnimation.value);
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: color,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   color: Colors.white,
          //   child: Center(
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Positioned(
          //           top: 300,
          //             child: Image.asset('assets/images/printzkart_logo.png',width: double.maxFinite,)),
          //         AnimatedBuilder(
          //           animation: _boxAnimation,
          //           builder: (context, child) {
          //             return Transform.translate(
          //               offset: Offset(0.0, _boxAnimation.value),
          //               child: Container(
          //                 width: double.maxFinite,
          //                 height: 500.0,
          //                 color: Colors.white,
          //                 child: Center(
          //                   child: Text(
          //                     'Logo',
          //                     style: TextStyle(fontSize: 24.0, color: Colors.white),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Center(child: Image.asset('assets/images/new_logo.png',width: 180,)),
          AnimatedBuilder(
            animation: _boxAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0.0, _boxAnimation.value),
                child: Container(
                  width: double.maxFinite,
                  height: 50.0,
                  // color: Colors.white,
                  color: color,
                ),
              );
            },
          ),
          // Positioned(
          //   bottom: 50.0,
          //   left: 0.0,
          //   right: 0.0,
          //   child: AnimatedTextKit(
          //     animatedTexts: [
          //       RotateAnimatedText('Loading 3d Models',textStyle: TextStyle(fontSize: 18),),
          //       RotateAnimatedText('Loading 3d Printers',textStyle: TextStyle(fontSize: 18),),
          //       RotateAnimatedText('Loading Filaments',textStyle: TextStyle(fontSize: 18),),
          //     ],
          //     onFinished: (){
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(builder: (context) => const LandingPage())
          //       );
          //     },
          //     totalRepeatCount: 1,
          //
          //   )
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: Dimensions.twenty),
              width: double.maxFinite,
              child: AnimatedTextKit(
                animatedTexts: [
                  customAnimatedTextWidget('Loading 3d Models'),
                  customAnimatedTextWidget('Loading 3d Printers'),
                  customAnimatedTextWidget('Loading Filaments'),
                  // RotateAnimatedText('Loading 3d Models',textStyle: const TextStyle(fontSize: 18),duration: Duration(milliseconds: 500)),
                  // RotateAnimatedText('Loading 3d Printers',textStyle: const TextStyle(fontSize: 18),duration: Duration(milliseconds: 500)),
                  // RotateAnimatedText('Loading Filaments',textStyle: const TextStyle(fontSize: 18),duration: Duration(milliseconds: 500)),
                  // CustomAnimatedText()
                ],
                onFinished: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LandingPage())
                  );
                },
                totalRepeatCount: 1,

              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   // mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     const SizedBox(width: 20.0, height: 100.0),
              //     const Text(
              //       'Loading ',
              //       style: TextStyle(fontSize: 18.0),
              //     ),
              //     // const SizedBox(width: 20.0, height: 100.0),
              //     AnimatedTextKit(
              //       animatedTexts: [
              //         RotateAnimatedText('Loading 3d Models',textStyle: TextStyle(fontSize: 18),rotateOut: true),
              //         RotateAnimatedText('Loading 3d Printers',textStyle: TextStyle(fontSize: 18),rotateOut: true),
              //         RotateAnimatedText('Loading Filaments',textStyle: TextStyle(fontSize: 18),rotateOut: true),
              //         // CustomAnimatedText()
              //       ],
              //       onFinished: (){
              //         Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(builder: (context) => const LandingPage())
              //         );
              //       },
              //       totalRepeatCount: 1,
              //
              //     ),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }

  // RotateAnimatedText customAnimatedTextWidget(string){
  //   const colorizeColors = [
  //     Colors.black,
  //     Colors.blue,
  //     Colors.orange,
  //     Colors.red,
  //   ];
  //   return RotateAnimatedText(
  //       string,
  //       textStyle: const TextStyle(fontSize: 18.0),
  //       // duration: Duration(milliseconds: 800)
  //   );
  // }

  // ColorizeAnimatedText customAnimatedTextWidget(string){
  //   const colorizeColors = [
  //     Colors.black,
  //     Colors.blue,
  //     Colors.orange,
  //     Colors.red,
  //   ];
  //   return  ColorizeAnimatedText(
  //     string,
  //     textStyle: TextStyle(fontSize: 18.0),
  //     colors: colorizeColors,
  //     textAlign: TextAlign.center,
  //     speed: Duration(milliseconds: 50)
  //   );
  // }

  TyperAnimatedText customAnimatedTextWidget(string){
    return TyperAnimatedText(string,textAlign: TextAlign.center,textStyle: TextStyle(fontSize: Dimensions.eighteen));
  }

}





// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//
//     _animationController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           // Logo Widget
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/printzkart_logo.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//           // Loading Text
//           Positioned(
//             bottom: 20,
//             child: Column(
//               children: [
//                 AnimatedOpacity(
//                   opacity: _animation.value,
//                   duration: const Duration(milliseconds: 500),
//                   child: const Text('Loading models'),
//                 ),
//                 AnimatedOpacity(
//                   opacity: _animation.value,
//                   duration: const Duration(milliseconds: 500),
//                   child: const Text('Loading printers'),
//                 ),
//                 AnimatedOpacity(
//                   opacity: _animation.value,
//                   duration: const Duration(milliseconds: 500),
//                   child: const Text('Loading filaments'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );
//
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Logo at the top
//           Container(
//             margin: EdgeInsets.only(top: 100.0),
//             child: Text(
//               'Your Logo',
//               style: TextStyle(fontSize: 24.0),
//             ),
//           ),
//
//           // Loading text at the bottom
//           FadeTransition(
//             opacity: _animation,
//             child: Container(
//               margin: EdgeInsets.only(bottom: 100.0),
//               child: Column(
//                 children: [
//                   Text('Loading models'),
//                   Text('Loading printers'),
//                   Text('Loading filaments'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }