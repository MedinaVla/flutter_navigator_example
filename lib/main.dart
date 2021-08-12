import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedUser = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage(child: UsersView(
            didSelectedUser: (user) {
              setState(() => _selectedUser = user);
            },
          )),
          if (_selectedUser.length > 0)
            MaterialPage(
              child: UserDetailsView(
                user: _selectedUser,
              ),
              key: UserDetailsView.valueKey,
            )
        ],
        onPopPage: (route, result) {
          final page = route.settings as MaterialPage;
          if (page.key == UserDetailsView.valueKey) _selectedUser = '';
          return route.didPop(result);
        },
      ),
    );
  }
}

class UsersView extends StatelessWidget {
  final _users = ["Yesenia", "Lubia", "Andrew", "Xavier", "Mya", "Vladimir"];
  late final ValueChanged didSelectedUser;

  UsersView({required this.didSelectedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _bodyBuilder(),
      ),
    );
  }

  ListView _bodyBuilder() {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return Card(
          child: ListTile(
            title: Text(user),
            onTap: () => didSelectedUser(user),
          ),
        );
      },
    );
  }
}

class UserDetailsView extends StatelessWidget {
  static const valueKey = ValueKey('UserDetailsView');

  final String user;

  const UserDetailsView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Center(
        child: Text('Hello, $user'),
      ),
    );
  }
}
