import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/services/database_helper.dart';
import 'package:reminder/services/provider.dart';
import 'package:reminder/services/service_locator.dart';

class CustomIcon extends StatefulWidget {
  final int index;

  CustomIcon(this.index);

  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.checkFavorites(provider.quoteList[widget.index].id),
      builder: (ctx, snap) {
        // print('IsFav??????????????????????? ${snap.data}');
        return Container(
          // margin: EdgeInsets.only(bottom: 20),
          child: IconButton(
            icon: snap.data == true
                ? Icon(
                    provider.icon = Icons.favorite,
                    color: Colors.redAccent,
                  )
                : Icon(provider.icon = Icons.favorite_border),
            onPressed: () async {
              provider.toggleLoading();
              setState(() {
                snap.data == true
                    ? provider.icon = Icons.favorite
                    : provider.icon = Icons.favorite_border;
                // print(snap.data);
              });

              var db = locator<DatabaseHelper>();
              bool isFav =
                  await db.isFavourite(provider.quoteList[widget.index].id);
              if (!isFav) {
                int success = await db.insert({
                  "quoteID": provider.quoteList[widget.index].id,
                  "quote": provider.quoteList[widget.index].text,
                  "author": provider.quoteList[widget.index].author,
                });

                print(success);
              } else {
                await db.delete(provider.quoteList[widget.index].id);
                // print('fuck you');
              }
              provider.toggleLoading();
            },
          ),
        );
      },
    );
  }
}
