import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/services/provider.dart';

class DeleteAll extends StatefulWidget {
  @override
  _DeleteAllState createState() => _DeleteAllState();
}

class _DeleteAllState extends State<DeleteAll> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.delete),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete all'),
          content: const Text('Do you want to delete all?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'OK');
                setState(() {
                  provider.deleteAllQueries();
                });

                await provider.loadQueries();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
    );
  }
}
// onPressed: () async {
// print('###############');
// setState(() {
// provider.deleteAllQueries();
// });
//
// await provider.loadQueries();
