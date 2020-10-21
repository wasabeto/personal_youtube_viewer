import 'package:flutter/material.dart';
import 'package:personal_youtube_viewer/models/channel_model.dart';

class CardChannelWidget extends StatelessWidget {
  final Channel channel;

  CardChannelWidget({@required this.channel});

  @override
  Widget build(BuildContext context) {
    double _marginX;
    if (MediaQuery.of(context).orientation == Orientation.portrait &&
        MediaQuery.of(context).size.width > 600) {
      _marginX = 50.0;
    } else {
      _marginX = 150.0;
    }

    return Card(
      shadowColor: Colors.red,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: _marginX),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: FadeInImage(
            image: NetworkImage(channel.profilePictureUrl),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          channel.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.supervised_user_circle,
              color: Colors.black26,
              size: 15.0,
            ),
            Text(channel.subscriberCount,
                style: Theme.of(context).textTheme.caption),
            SizedBox(width: 10.0),
            Icon(
              Icons.video_library,
              color: Colors.black26,
              size: 15.0,
            ),
            Text(channel.subscriberCount,
                style: Theme.of(context).textTheme.caption),
          ],
        ),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.pushNamed(context, 'channel-detail', arguments: channel);
        },
      ),
    );
  }
}
