import 'package:flutter/material.dart';

void main() {
  runApp(HopkinsGirlsFlagFootballApp());
}

class HopkinsGirlsFlagFootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hopkins Girls Flag Football',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue[800],
          secondary: Colors.yellow[700],
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hopkins Girls Flag Football')),
      body: ListView(
        children: [
          ListTile(title: Text('Registration'), onTap: () {
            // Navigate to Registration screen
          }),
          ListTile(title: Text('Scholarship Application'), onTap: () {
            // Navigate to Scholarship Application screen
          }),
          ListTile(title: Text('Speed Training'), onTap: () {
            // Navigate to Speed Training screen
          }),
          ListTile(title: Text('Surveys'), onTap: () {
            // Navigate to Surveys screen
          }),
          ListTile(title: Text('Practice Schedule'), onTap: () {
            // Navigate to Practice Schedule screen
          }),
          ListTile(title: Text('Game Schedule'), onTap: () {
            // Navigate to Game Schedule screen
          }),
          ListTile(title: Text('Team Links'), onTap: () {
            // Navigate to Team Links screen
          }),
        ],
      ),
    );
  }
}