import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.lightBlueAccent,
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.width - 200,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            ListTile(
              title: Text('Project 1'),
              subtitle: Text('Change the interfaces'),
            ),
            ListTile(
              title: Text('Project 2'),
              subtitle: Text('Create new Dashboard'),
            ),
            ListTile(
              title: Text('Project 3'),
              subtitle: Text('Meeting at 10.30 AM'),
            ),
          ],
        )
      ),
    );
  }
}
