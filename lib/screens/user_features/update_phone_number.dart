import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/show_message.dart';

class UpdatePhoneNumberScreen extends StatefulWidget {
  @override
  _UpdatePhoneNumberScreenState createState() => _UpdatePhoneNumberScreenState();
}

class _UpdatePhoneNumberScreenState extends State<UpdatePhoneNumberScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  String? _verificationId;

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatic verification or instant validation
        await _auth.currentUser?.updatePhoneNumber(credential);
        // Phone number update successful
        showToast("Successfully updated phone number");
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
        print('Verification failed: $e');
        showToast(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID for later use
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  Future<void> _updatePhoneNumber(String verificationCode) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: verificationCode,
    );

    try {
      await _auth.currentUser?.updatePhoneNumber(credential);
      // Phone number update successful
      showToast("Successfully updated phone number");
    } catch (e) {
      // Handle the error
      print('Error updating phone number: $e');
      showToast(e.toString());
    }
  }

  @override
  void dispose() {
    _verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _phoneNumber,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                // Update phone number value
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // Verify phone number
                final phoneNumber = _phoneNumber.text; // Provide the phone number to verify
                await _verifyPhoneNumber(phoneNumber);
              },
              child: const Text('Verify Phone Number'),
            ),
            TextFormField(
              controller: _verificationCodeController,
              decoration: const InputDecoration(labelText: 'Verification Code'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                // Update phone number with verification code
                final verificationCode = _verificationCodeController.text;
                await _updatePhoneNumber(verificationCode);
              },
              child: const Text('Update Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
