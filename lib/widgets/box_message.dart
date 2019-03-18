
import 'package:flutter/material.dart';

class BoxMessage extends StatelessWidget {

  final String message;

  const BoxMessage(this.message);

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
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage("https://www.ibm.com/watson/assets/duo/img/common/avatar_purple.png"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Watson",
                style:Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    this.message
                    // style: Theme.of(context).textTheme.display1,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
