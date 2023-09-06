import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Text> sendTextList = [];
  double lightBoxOpacity = 0, backgroundOpacity = 0.2;
  bool isLightRunning = false;
  late Timer lightTimer;

  onLightTap() {
    if (isLightRunning == false) {
      isLightRunning = true;
      if (backgroundOpacity <= 0.9) {
        backgroundOpacity = backgroundOpacity + 0.2;
      }

      lightTimer = Timer.periodic(
        const Duration(milliseconds: 50),
        (timer) {
          setState(
            () {
              if (lightBoxOpacity <= 0.1) {
                lightBoxOpacity = 0;
                timer.cancel();
                isLightRunning = false;
              } else {
                lightBoxOpacity = lightBoxOpacity - 0.02;
              }
            },
          );
        },
      );
      setState(
        () {
          lightBoxOpacity = 1;
          addSendText("불을 지폈습니다...");
        },
      );
    } else {
      setState(() {
        addSendText("기다리는중...");
      });
    }
  }

  addSendText(String text) {
    if (sendTextList.length == 20) {
      sendTextList.remove(sendTextList[0]);
    }
    sendTextList.add(
      Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(backgroundOpacity),
        body: Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: SizedBox()),
                  Expanded(
                    flex: 1,
                    child: ListView.separated(
                      reverse: true,
                      itemBuilder: (context, index) {
                        var reverse = sendTextList.length - index - 1;
                        return sendTextList[reverse];
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 40,
                      ),
                      itemCount: sendTextList.length,
                    ),
                  ),
                  const Flexible(child: SizedBox()),
                ],
              ),
            ),
            Flexible(
              child: Center(
                child: GestureDetector(
                  onTap: onLightTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 140,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(lightBoxOpacity),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Text("LIGHT"),
                  ),
                ),
              ),
            ),
            const Flexible(child: Text("adf"))
          ],
        ),
      ),
    );
  }
}
