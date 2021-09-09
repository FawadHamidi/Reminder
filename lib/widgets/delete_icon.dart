import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/services/database_helper.dart';
import 'package:reminder/services/provider.dart';
import 'package:reminder/services/service_locator.dart';

class DeleteQuote extends StatefulWidget {
  final int index;
  final ValueChanged<int> onDelete;

  DeleteQuote(this.index, {this.onDelete});

  @override
  _DeleteQuoteState createState() => _DeleteQuoteState();
}

class _DeleteQuoteState extends State<DeleteQuote> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          print('###############');

          widget.onDelete(widget.index);
          setState(() {
            var db = locator<DatabaseHelper>();
            db.delete(provider.queryList[widget.index].id);
          });

          await provider.loadQueries();
        });
  }
}
