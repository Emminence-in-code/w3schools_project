import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel customViewModel(
    BuildContext context, String backgroundImage, String title, String body) {
  return PageViewModel(
    titleWidget: Container(
        width: MediaQuery.of(context).size.width,
        height: 350,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(backgroundImage)),),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image.png'),
                        ))))
          ],
        )),
    // titleWidget: const SizedBox(),
    bodyWidget: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          body,
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}
