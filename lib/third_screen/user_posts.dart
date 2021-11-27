import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class UserPosts extends StatefulWidget {
  final String name;
  final int indx;
  final int profindx;
  UserPosts(
      {Key key,
      @required this.name,
      @required this.indx,
      @required this.profindx})
      : super(key: key);

  @override
  _UserPostsState createState() =>
      _UserPostsState(name: name, indx: indx, profindx: profindx);
}

class _UserPostsState extends State<UserPosts> {
  String name;
  int indx;
  int profindx;
  _UserPostsState(
      {@required this.name, @required this.indx, @required this.profindx});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  ClipOval(
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: 'https://picsum.photos/id/$profindx/50',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://picsum.photos/id/$indx/320',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
