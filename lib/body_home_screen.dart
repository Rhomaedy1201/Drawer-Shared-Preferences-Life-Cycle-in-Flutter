import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class Body_home_screen extends StatelessWidget {
  var faker = new Faker();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ChatItems(
          imageUrl: "https://picsum.photos/id/$index/200/300",
          title: faker.person.name(),
          subTitle: faker.lorem.sentence(),
        );
      },
    );
  }
}

class ChatItems extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subTitle;
  ChatItems({Key? key, this.imageUrl, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: -5, left: 10, right: 10),
      title: Text("$title"),
      subtitle: Text(
        "$subTitle",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16),
      ),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage('$imageUrl'),
      ),
      trailing: Text("20.40"),
    );
  }
}
