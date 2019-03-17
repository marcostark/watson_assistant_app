import 'package:flutter/material.dart';
import 'package:watson_assistant/watson_assistant.dart';
import 'package:watson_assistant_app/util/constants.dart';

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

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    myController.clear();
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
            // Expanded(
            //   child: ListView(
            //     children: <Widget>[
            //       BoxMessage(),
            //       BoxMessage(),
            //       BoxMessage(),
            //     ],
            //   ),
            // ),
            // Divider(height: 1.0,),
            // Container(
            //   decoration: BoxDecoration(color: Colors.white),
            //   child: TextComposer(),
            // )

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: myController,
                  ),
                  Text(
                    _text != null ? '$_text' : 'Resposta do Watson',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _callWatsonAssistant,
          child: Icon(Icons.send),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;

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
                decoration:
                    InputDecoration.collapsed(hintText: "Digite a mensagem"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing ? (){} :null,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BoxMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://www.ibm.com/watson/assets/duo/img/common/avatar_purple.png"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Stark",
                style:Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text("teste"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
