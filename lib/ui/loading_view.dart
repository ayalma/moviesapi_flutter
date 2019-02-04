import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  final VoidCallback onPressed;
  final Object error;
  const LoadingView({Key key,@required this.onPressed,this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.signal_wifi_off,
            size: 32,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "No internet connection",
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(
            height: 16.0,
          ),
          OutlineButton.icon(
            onPressed: onPressed,
            icon: Icon(Icons.refresh),
            label: Text("retry"),
          ),
        ],
      ),
    );
  }
}
