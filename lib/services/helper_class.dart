import 'dart:typed_data';
import 'dart:io';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

launchURL(link) async {
  const url = 'https://example.com';
  if (await canLaunchUrl(Uri.parse(link))) {
    await launchUrl(Uri.parse(link));
  } else {
    throw 'Could not launch $link';
  }
}

shareFile(imageUrl, msg) async {
  Future<Uint8List> getBytesFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  final bytes = await getBytesFromUrl(imageUrl);
  final tempDir = await getTemporaryDirectory();
  final file = await File('${tempDir.path}/image.jpg').create();
  await file.writeAsBytes(bytes.buffer.asUint8List());

  Share.shareFiles([file.path], text: msg);

  // const appName = AppInfo.appName;
  // const playStoreLink = AppInfo.playStoreLink;
  // await Share.shareFiles([link], text: msg);
  // await Share.share('$link $msg');
}
