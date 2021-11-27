import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Stories extends StatefulWidget {
  final String name;
  final int indx;
  Stories({Key key, @required this.name, @required this.indx})
      : super(key: key);

  @override
  _StoriesState createState() => _StoriesState(name: name, indx: indx);
}

class _StoriesState extends State<Stories> {
  String name;
  int indx;
  _StoriesState({@required this.name, @required this.indx});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              ClipOval(
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/id/$indx/70',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(name)
        ],
      ),
    );
  }
}
