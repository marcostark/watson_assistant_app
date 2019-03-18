import 'package:flutter/material.dart';
import 'package:watson_assistant_app/screens/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watson Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(title: 'Watson Assistant'),
    );
  }
}
