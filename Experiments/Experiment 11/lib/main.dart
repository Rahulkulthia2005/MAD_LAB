import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web User List',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _users = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('users');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      setState(() {
        _users = List<Map<String, dynamic>>.from(decoded);
      });
    }
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('users', jsonEncode(_users));
  }

  Future<void> _addUser(String name, int age) async {
    setState(() {
      _users.add({'name': name, 'age': age});
    });
    await _saveUsers();
    _nameController.clear();
    _ageController.clear();
  }

  Future<void> _deleteUser(int index) async {
    setState(() {
      _users.removeAt(index);
    });
    await _saveUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List - Flutter Web')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();
                final age = int.tryParse(_ageController.text.trim());
                if (name.isNotEmpty && age != null) {
                  _addUser(name, age);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enter valid name and age')),
                  );
                }
              },
              child: Text('Add User'),
            ),
            Divider(height: 30),
            Expanded(
              child: _users.isEmpty
                  ? Center(child: Text('No users found'))
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Card(
                          child: ListTile(
                            title: Text(user['name']),
                            subtitle: Text('Age: ${user['age']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteUser(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
