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
          title: Text('YouTube channel list'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Column(
                children: CHANNEL_LIST.map((channelId) {
                  return _createCardChannel(channelId);
                }).toList(),
              ),
            )));
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
