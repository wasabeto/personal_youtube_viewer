import 'package:flutter/material.dart';
import 'package:personal_youtube_viewer/models/channel_model.dart';

class CardChannelWidget extends StatelessWidget {
  final Channel channel;

  CardChannelWidget({@required this.channel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 90.0,
                image: NetworkImage(channel.profilePictureUrl),
                placeholder: AssetImage('assets/youtube_channel.png'),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(channel.title,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis),
                    Text(
                      '${channel.subscriberCount} subscribers',
                      style: TextStyle(fontSize: 10.0),
                    ),
                    Text(
                      '${channel.videoCount} videos',
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'channel-detail', arguments: channel);
      },
    );
  }
}
