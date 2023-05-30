import 'package:flutter/material.dart';

import '../constants/dimensions.dart';


class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  _DropDownState() {
    gender = genderList[0];
  }

  String gender = '';
  List genderList = ['Male', 'Female', 'Other'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.ten),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45,width: 0.3),
            borderRadius: BorderRadius.circular(Dimensions.radius12)
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


