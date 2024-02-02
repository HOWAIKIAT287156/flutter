import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final double totalprice;
  final User userdata;

  const PaymentPage({Key? key, required this.totalprice, required this.userdata}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    print(widget.userdata.username);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
            '${ServerConfig.server}/bookbytes/php/payment.php?totalprice=${widget.totalprice}&userid=${widget.userdata.userid}&usercontact=${widget.userdata.usercontact}&useremail=${widget.userdata.useremail}&username=${widget.userdata.username}'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}



