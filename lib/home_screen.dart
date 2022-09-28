import 'package:drawer_shared_life_sycle/body_home_screen.dart';
import 'package:drawer_shared_life_sycle/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              iconSize: 26,
            ),
          ],
        ),
        body: Body_home_screen(),
        drawer: Drawer_Navigator(),
      ),
    );
  }
}

class Drawer_Navigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: 350,
            height: 180,
            color: Colors.purple,
            padding: EdgeInsets.only(left: 20, bottom: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/user.jpg'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Muhammad Rhomaedi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "rhomaedy12345@gmail.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Dahsboard",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
              "New Grup",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.perm_contact_cal),
            title: Text(
              "Contact",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text(
              "Message",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Screen_login()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
