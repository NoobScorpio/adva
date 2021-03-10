import 'package:adva/res/appStrings.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class CardPaymentScreen extends StatefulWidget {
  final total;
  final id;

  CardPaymentScreen({this.total, this.id});
  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  // InAppWebViewController webView;
  String url = "";
  double progress = 0;
  final GlobalKey<ScaffoldState> globKeyPay = new GlobalKey<ScaffoldState>();
  void showSnack(text) {
    globKeyPay.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(text),
      duration: Duration(seconds: 5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    String _loadHTML() {
      return '''
  <html>
  <body onload="document.f.submit();">
  <form id="f" name="f" method="post" action="$baseURL/order/mobile/create">
  <input type="hidden" name="total" value="${widget.total}"/>
  <input type="hidden" name="customer_id" value="${widget.id}"/>

  </form>
  </body>
  </html>
  ''';
    }

    return Scaffold(
      key: globKeyPay,
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebView(
        onPageFinished: (page) async {
          if (page.contains('/order/validate/success')) {
            String id = page.substring(page.indexOf("?id=") + 4, page.length);
            print("@PAGE ID $id");
            Navigator.pop(context, id);
          }
          // }
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            // '',
            // 'https://google.com.pk'
            Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString(),
      ),
    );
  }
}
