import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w3schools_project/widgets/custom_dialog.dart';
import 'package:w3schools_project/widgets/online_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.initialUrl, required this.pref});
  String? initialUrl;
  final SharedPreferences pref;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late WebViewController controller;
  bool hasError = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //OBSERVE THE CURRENT WIDGET
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.initialUrl!));
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {
        setState(() {
          hasError = false;
        });
      },
      
      onWebResourceError: (WebResourceError error) {
        if (error.errorType == WebResourceErrorType.hostLookup|| error.errorType == WebResourceErrorType.badUrl||error.errorType == WebResourceErrorType.timeout ) {
          print('err host lookup error');
          setState(() {
            hasError = true;
          });
        }
      },

      onNavigationRequest: (request) async {
        return NavigationDecision.navigate;
      },
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    getCurrentUrl().then((value) {
      widget.pref.setBool('intro', false);
      return widget.pref.setString('initialUrl', value!);
    });

    // super.didChangeAppLifecycleState(state);
  }

  Future<String?> getCurrentUrl() async {
    return await controller.currentUrl();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // canPop: true,
      onWillPop: () async {
        if (await controller.canGoBack()) {
          await controller.goBack();
        } else {
          await showdialog(context) ?? false;
        }
        return controller.canGoBack();
      },
      child: !hasError
          ? OnlineScaffold(controller: controller)
          : Scaffold(
              body: Column(
              children: [
                const SizedBox(height: 70),
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('assets/img.jpg'))),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Please Check Your Internet Connection',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await controller.reload();
                    },
                    child: const Text('Reload')),
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'assets/image.png',
                  height: 50,
                )
              ],
            )),
    );
  }
}
