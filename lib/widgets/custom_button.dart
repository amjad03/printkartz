import 'package:flutter/material.dart';
import 'package:printzkart/constants/dimensions.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;
  final String title;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius50), // Add border radius here
          ),
          padding: EdgeInsets.symmetric(vertical: Dimensions.fifteen)
        ),
        onPressed: widget.onPressed,
        child: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: Dimensions.fifteen,fontFamily: 'Inter'),),
      ),
    );
  }
}

ElevatedButton customRoundedButton(
    String text, IconData icon, {
      required VoidCallback onPressed,
    }) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(text,style: const TextStyle(color: Colors.white),),
        SizedBox(width: Dimensions.width10,),
        Icon(icon,size: 18,color: Colors.white,)
      ],
    )
  );
}

