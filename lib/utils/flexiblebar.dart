import 'package:flutter/material.dart';

class Flexiblebar extends StatefulWidget implements PreferredSizeWidget {
  Flexiblebar({Key key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _FlexiblebarState createState() => _FlexiblebarState();
}

class _FlexiblebarState extends State<Flexiblebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          children: [
            Expanded(flex: 1, child: SizedBox(width: 2)),
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Shop",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "About",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 25,
                        color: Colors.black,
                      ),
                      Positioned(
                        right: 0.0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 13,
                            minHeight: 13,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              //mynewCartlength == null ? "0" :
                              "0",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Cart",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                //margin: EdgeInsets.all(7),
                height: MediaQuery.of(context).size.height / 20.1,
                width: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey[500],
                  //     blurRadius: 1.0,
                  //     spreadRadius: 0.0,
                  //     offset: Offset(0, 1.5), // shadow direction: bottom right
                  //   )
                  // ],
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(240, 240, 240, 1),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 15,
                          child: TextField(
                            // onTap: () {
                            //   FocusManager.instance.primaryFocus.unfocus();

                            //   showSearch(
                            //       context: context, delegate: DataSearch());
                            // },
                            //controller: searchcontroller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              hintText: "Search Here",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 3.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(224, 116, 82, 1),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(224, 116, 82, 1),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: IconButton(
                            alignment: Alignment.center,
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
