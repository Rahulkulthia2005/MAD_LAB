import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: Column(
        children: [
          // Profile Card
          Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/v2/D5603AQFJv7UypIWBwg/profile-displayphoto-shrink_400_400/B56ZY02yzVGQAg-/0/1744643504034?e=1750291200&v=beta&t=thN0j_pAJf7Ek22-MSCtSDTGiMk0JQidtE7Akz7YQjA',
                ),
              ),
              title: Text('Rahul Kulthia'),
              subtitle: Text('Flutter Developer'),
            ),
          ),
          // Image Gallery using GridView
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    'https://picsum.photos/200?random=$index',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
