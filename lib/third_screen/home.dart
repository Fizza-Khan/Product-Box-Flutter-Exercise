import '../third_screen/bubble_stories.dart';
import '../third_screen/user_posts.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  static const routeName = '/insta_home';
  final List people = [
    'Fizza',
    'Maha',
    'Ayesha',
    'Tehreem',
    'Sahar',
    'Zoya',
    'Shanzay',
    'Wania',
    'TeddyBear',
    'Maryam'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(
              height: 130,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return Stories(
                      name: people[index],
                      indx: index,
                    );
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return UserPosts(
                      name: people[index],
                      indx: index + 10,
                      profindx: index,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
