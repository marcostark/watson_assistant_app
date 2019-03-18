import 'package:flutter/material.dart';
import 'package:watson_assistant/watson_assistant.dart';
import 'package:watson_assistant_app/util/constants.dart';
import 'package:watson_assistant_app/widgets/box_message.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _text;
  WatsonAssistantCredential credential = WatsonAssistantCredential(
      username: Constants.USERNAME,
      password: Constants.PASSWORD,
      workspaceId: Constants.WORKSPACEID);

  WatsonAssistantApiV1 watsonAssistant;
  WatsonAssistantResult watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  final myController = TextEditingController();
  bool _isComposing = false;

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    _clear();
    _isComposing = false;
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV1(watsonAssistantCredential: credential);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.restore,
              ),
              onPressed: () {
                watsonAssistantContext.resetContext();
                setState(() {
                  _text = null;
                });
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                reverse: true,
                children: <Widget>[
                  BoxMessage(
                    _text != null ? '$_text' : '...',
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: _textComposer(),              
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _clear() {
    myController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  Widget _textComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: TextField(
                controller: myController,
                decoration:
                    InputDecoration.collapsed(hintText: "Digite a mensagem"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: (text){
                  _callWatsonAssistant;
                  _clear();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing ? _callWatsonAssistant : null,
              ),
            )
          ],
        ),
      ),
    );
  }

}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _controller =TextEditingController();
  bool _isComposing = false;

  void _clear(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration:
                    InputDecoration.collapsed(hintText: "Digite a mensagem"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: (text){
                  _sendMessage(_controller.text);
                  _clear();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing ? (){
                  _sendMessage(_controller.text);
                  _clear();
                } :null,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _sendMessage(String text){
  print(text);
}
