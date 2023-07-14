import 'package:flutter/material.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';
// import 'package:flutter_email_sender/flutter_email_sender.dart';


import '../constants/constants.dart';
import '../widgets/show_message.dart';


void sendFeedbackEmail(String feedbackText, recipient) async {
  // String username = 'razaamjad057@gmail.com';
  // String password = 'Abujiamiji@3';
  //
  // final smtpServer = gmail(username, password);
  // // final smtpServer = gmail(Strings.email, ''); // Replace with your email and password
  //
  // final message = Message()
  //   // ..from = const Address(Strings.email)
  //   ..from = Address(username,'Amjad')
  //   ..recipients.add('amjadraza676@gmail.com') // Replace with the recipient email address
  //   ..subject = 'Feedback'
  //   ..text = feedbackText;
  //
  // try {
  //   final sendReport = await send(message, smtpServer);
  //   showToast('Successfully Sent');
  //   print('Message sent: ${sendReport.toString()}');
  // } catch (e) {
  //   print('Error sending email: $e');
  //   showToast('Error Sending..');
  // }
}

void sendHelpEmail(String helpText, recipient) async {

  // String username = 'razaamjad057@gmail.com';
  // String password = 'Abujiamiji@3';

  // final smtpServer = gmail(username, password);
  // final smtpServer = gmail(Strings.email, ''); // Replace with your email and password

  // final message = Message()
  //   ..from = Address(username,'Amjad')
  //   ..recipients.add('amjadraza676@gmail.com') // Replace with the recipient email address
  //   ..subject = 'Help'
  //   ..text = helpText;
  // final smtpServer = gmail(Strings.email, 'Abujiamiji@3'); // Replace with your email and password

  // final message = Message()
  //   ..from = const Address(Strings.email)
  //   ..recipients.add(recipient) // Replace with the recipient email address
  //   ..subject = 'Help Message'
  //   ..text = helpText;

  // try {
  //   final sendReport = await send(message, smtpServer);
  //   // showToast('Successfully Sent');
  //   showToast("Successfully received, we will resolve your help as soon as possible");
  //
  //   print('Message sent: ${sendReport.toString()}');
  // } catch (e) {
  //   print('Error sending email: $e');
  //   showToast(e.toString());
  // }

  // final Uri emailUri = Uri(
  //   scheme: 'mailto',
  //   path: 'amjadraza676@gmail.com', // Replace with the recipient email address
  //   queryParameters: {
  //     'subject': 'Feedback',
  //     'body': 'Your feedback message goes here',
  //   },
  // );
  //
  // if (await canLaunchUrl(emailUri)) {
  //   await launchUrl(emailUri);
  // } else {
  //   throw 'Could not launch email client';
  // }

  // final Email email = Email(
  //   body: helpText,
  //   subject: 'Email subject',
  //   recipients: [Strings.email],
  //   isHTML: false,
  // );
  //
  // await FlutterEmailSender.send(email);
}

// Future<void> send(msg) async {
//
//   final recipient = Strings.email.toString();
//   final Email email = Email(
//     body: msg,
//     subject: "Help Message",
//     recipients: [recipient],
//     isHTML: false,
//   );
//
//   String platformResponse;
//
//   try {
//     await FlutterEmailSender.send(email);
//     platformResponse = 'success';
//   } catch (error) {
//     print(error);
//     platformResponse = error.toString();
//   }
//
//   showToast(platformResponse);
//
//   // if (!mounted) return;
//
//   // ScaffoldMessenger.of(context).showSnackBar(
//   //   SnackBar(
//   //     content: Text(platformResponse),
//   //   ),
//   // );
// }
