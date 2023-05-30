import 'package:flutter/material.dart';

import '../constants/dimensions.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.label,
      required this.password,
      required this.phoneNumber,
      required this.maxLines, required this.isFor})
      : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String isFor;
  final bool password;
  final bool phoneNumber;
  final int maxLines;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

// class _CustomInputFieldState extends State<CustomInputField> {
//
//   bool show = true;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     var iconColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45 ;
//
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: EdgeInsets.all(Dimensions.ten),
//         child: TextFormField(
//           controller: widget.controller,
//           textAlign: TextAlign.start,
//           cursorColor: Colors.grey,
//           obscureText: widget.password ? show : false,
//           keyboardType: widget.phoneNumber ? TextInputType.number : TextInputType.text,
//           maxLines: widget.maxLines,
//           decoration: InputDecoration(
//               focusColor: Colors.grey,
//               contentPadding: EdgeInsets.all(Dimensions.fifteen),
//               label: Text(widget.label),
//               prefixIcon: Icon(widget.icon,color: Colors.grey,),
//               suffixIcon:
//               widget.password
//                   ?
//               show
//                   ? IconButton(icon: const Icon(Icons.visibility,color: Colors.grey,), onPressed: () {
//                 setState(() {
//                   show = !show;
//                 });
//               },)
//                   : IconButton(icon: const Icon(Icons.visibility_off,color: Colors.grey,), onPressed: () {
//                 setState(() {
//                   show = !show;
//                 });
//               },)
//                   : null ,
//               border: const OutlineInputBorder(),
//               iconColor: iconColor,
//               labelStyle: TextStyle(color: iconColor),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     width: 2,
//                     color: iconColor
//                 ),
//               ),
//           ),
//           validator: (value){
//             if(value.toString().isEmpty){
//               return "Required";
//             }
//             else {
//               return null;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

class _CustomInputFieldState extends State<CustomInputField> {
  bool show = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.ten),
        child: TextFormField(
          controller: widget.controller,
          textAlign: TextAlign.start,
          cursorColor: Colors.grey,
          obscureText: widget.password ? show : false,
          keyboardType: widget.phoneNumber ? TextInputType.number : TextInputType.text,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            focusColor: Colors.grey,
            contentPadding: EdgeInsets.all(Dimensions.fifteen),
            label: Text(widget.label),
            prefixIcon: Icon(
              widget.icon,
              color: Colors.grey,
            ),
            suffixIcon: widget.password
                ? show
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
            )
                : null,
            border: const OutlineInputBorder(),
            iconColor: iconColor,
            labelStyle: TextStyle(color: iconColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: iconColor),
            ),
          ),
          validator: (value) {
            if (widget.isFor == 'Name' && value.toString().isEmpty) {
              return "Name is required";
            }
            else if (widget.isFor == 'Phone' && (value == null || value.length < 10)) {
              return "Please enter a valid phone number";
            }
            else if (widget.isFor == 'Email' && (value == null || !isEmail(value))) {
              return "Please enter a valid email address";
            }
            else if (widget.isFor == 'Password' && (value == null || value.length < 8)) {
              return "Password must be at least 8 characters";
            }
            else if (widget.isFor == 'Feedback' && value.toString().isEmpty) {
              return "This field is required";
            }
            else if (widget.isFor == 'Help' && value.toString().isEmpty) {
              return "This field is required";
            }
            else {
              return null;
            }
          },
        ),
      ),
    );
  }

  bool isEmail(String value) {
    // Use regex to validate email format
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }
}




class CustomInputWithTrailing extends StatefulWidget {
  const CustomInputWithTrailing({Key? key, required this.controller, required this.icon, required this.label,}) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String label;

  @override
  State<CustomInputWithTrailing> createState() => _CustomInputWithTrailingState();
}

class _CustomInputWithTrailingState extends State<CustomInputWithTrailing> {

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black45 ;
    return Padding(
      padding: EdgeInsets.all(Dimensions.ten),
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.start,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(Dimensions.fifteen),
            label: Text(widget.label),
            prefixIcon: Icon(widget.icon,color: Colors.grey,),
            border: const OutlineInputBorder(),
            iconColor: color,
            labelStyle: TextStyle(color: color),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: color
              ),
            )
        ),
        validator: (value){
          if(value.toString().isEmpty){
            return "Required";
          }
          else {
            return null;
          }
        },
      ),
    );
  }
}

