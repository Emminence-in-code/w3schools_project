import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlineScaffold extends StatelessWidget {
  const OnlineScaffold({
    super.key,
    required this.controller,
  });

  final WebViewController controller;



  @override
//import flutter inappwebview to use this reload function
  //   late PullToRefreshController pullToRefreshController =
  //     PullToRefreshController(
  //   options: PullToRefreshOptions(
  //     color: Colors.blue,
  //   ),
  //   onRefresh: () async {
  //     if (Platform.isAndroid) {
  //       webViewController?.reload();
  //     }
  //   },
  // );
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 100, 10),
      floatingActionButton: FloatingActionButton(
        onPressed: () async  {
         await controller.reload();
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.replay,
          color: Color.fromARGB(255, 7, 100, 10),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.reload();
                    },
                    child: WebViewWidget(controller: controller)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}