import 'package:flutter/material.dart';
import 'package:personal_youtube_viewer/models/channel_model.dart';
import 'package:personal_youtube_viewer/services/api_service.dart';
import 'package:personal_youtube_viewer/utilities/keys.dart';
import 'package:personal_youtube_viewer/widgets/card_channel_widget.dart';

class ChannelListScreen extends StatefulWidget {
  ChannelListScreen({Key key}) : super(key: key);

  @override
  _ChannelListScreenState createState() => _ChannelListScreenState();
}

class _ChannelListScreenState extends State<ChannelListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Channel list'),
          actions: [
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.supervised_user_circle),
              textColor: Colors.white,
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: ListView(
          children: CHANNEL_LIST
              .map((channelId) => _createCardChannel(channelId))
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          child: Icon(Icons.add),
          onPressed: () {
            _showParentControlDialog().then((value) {
              if (value.toUpperCase() == 'H2O') {
                _addYouTubeChannelDialog().then((value) {
                  print(value);
                });
              } else {
                print('RESULT IS WRONG!!!');
              }
            });
          },
          tooltip: 'Add a new channel',
        ));
  }

  Future<String> _showParentControlDialog() async {
    TextEditingController textEditingController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please answer this question'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('What is the chemical representation of water?'),
                TextField(
                  controller: textEditingController,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Verify'),
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text.toString());
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<String> _addYouTubeChannelDialog() async {
    TextEditingController textEditingController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add the channel ID'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Channel ID',
                    hintText: 'Enter a valid YouTube channel ID'
                  ),
                  validator: (String value) {
                    return value.contains(' ') ? 'Enter a single ID' : null;
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text.toString());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _createCardChannel(String channelId) {
    return FutureBuilder(
        future: APIService.instance.fetchChannel(channelId: channelId),
        builder: (BuildContext context, AsyncSnapshot<Channel> snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              CardChannelWidget(channel: snapshot.data),
              SizedBox(
                height: 30.0,
              )
            ]);
          } else {
            return Center(
              child: Container(
                  height: 100,
                  child: Center(child: CircularProgressIndicator())),
            );
          }
        });
  }
}
