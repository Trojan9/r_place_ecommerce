import 'package:flutter/material.dart';

class Pinnedbar extends StatefulWidget implements PreferredSizeWidget {
  Pinnedbar({Key key})
      : preferredSize = Size.fromHeight(30.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _PinnedbarState createState() => _PinnedbarState();
}

class _PinnedbarState extends State<Pinnedbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 7,
      // width: MediaQuery.of(context).size.width,

      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/logo.png",
                width: 50,
                height: 50,
              ),
            ),
            Expanded(flex: 9, child: Text(""))
          ]),
    );
  }
}
