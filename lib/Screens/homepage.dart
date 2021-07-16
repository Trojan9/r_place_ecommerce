import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:r_place/utils/products.dart';
import 'package:r_place/utils/pinnedbar.dart';
import 'package:r_place/utils/flexiblebar.dart';
import 'package:webscrollbar/webscrollbar.dart';

const int DEFAULT_SCROLL_SPEED = 130;
const int DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS = 250;
var images = ["assets/image1.png", "assets/image2.png"];
var products = [
  "assets/products/1.png",
  "assets/products/2.png",
  "assets/products/3.png",
  "assets/products/4.png",
  "assets/products/5.png",
  "assets/products/6.png",
  "assets/products/7.png",
  "assets/products/8.png",
];

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool hover = false;
  ScrollController controller = ScrollController();
  final int scrollSpeed = DEFAULT_SCROLL_SPEED;
  final Curve curve = Curves.linear;
  final int scrollAnimationLength = DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS;
  double _scroll = 0;
//the fadein animation
  bool _firstChild = false;
  //using this for the hover function
  int _enterCounter = 0;
  int _exitCounter = 0;
  // double x = 0.0;
  // double y = 0.0;

  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      hover = false;
      _exitCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      hover = true;
      // x = details.position.dx;
      // y = details.position.dy;
    });
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  void route() {
    setState(() {
      _firstChild = !_firstChild;
    });
    startTime();
  }

  bool changepin = false;
  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      if (controller.position.activity is IdleScrollActivity) {
        _scroll = controller.position.extentBefore;
      }
      if (_scroll > 20.0) {
        if (!changepin) {
          setState(() {
            changepin = true;
          });
        }
      }
      if (_scroll < 20.0) {
        setState(() {
          changepin = false;
        });
      }
    });
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        int millis = scrollAnimationLength;

        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          setState(() {
            _scroll += scrollSpeed;
          });
          if (_scroll > controller.position.maxScrollExtent) {
            _scroll = controller.position.maxScrollExtent;
            millis = scrollAnimationLength ~/ 2;
          }

          if (_scroll < 0) {
            _scroll = 0;
            millis = scrollAnimationLength ~/ 2;
          }

          controller.animateTo(
            _scroll,
            duration: Duration(milliseconds: millis),
            curve: curve,
          );
          if (_scroll > 20.0) {
            if (!changepin) {
              setState(() {
                changepin = true;
              });
            }
          }
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          setState(() {
            _scroll -= scrollSpeed;
          });
          if (_scroll > controller.position.maxScrollExtent) {
            _scroll = controller.position.maxScrollExtent;
            millis = scrollAnimationLength ~/ 2;
          }

          if (_scroll < 0) {
            _scroll = 0;
            millis = scrollAnimationLength ~/ 2;
            if (changepin) {
              setState(() {
                changepin = false;
              });
            }
          }
          if (_scroll < 20.0) {
            setState(() {
              changepin = false;
            });
          }

          controller.animateTo(
            _scroll,
            duration: Duration(milliseconds: millis),
            curve: curve,
          );
        }
        // print(event.logicalKey.keyLabel);
      },
      autofocus: true,
      child: Container(
        color: Colors.red,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            minimum: EdgeInsets.only(
              top: 30,
            ),
            child: WebScrollBar(
              controller: controller,
              visibleHeight: 50,
              child: CustomScrollView(controller: controller, slivers: [
                SliverAppBar(
                    expandedHeight: 150.0,
                    floating: false,
                    elevation: 10.0,
                    pinned: true,
                    primary: true,
                    backgroundColor: Colors.white,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                    title: changepin
                        ? Flexiblebar()
                        : PreferredSize(
                            preferredSize: Size.fromHeight(100.0),
                            child: Pinnedbar()),
                    // primary: true,
                    automaticallyImplyLeading: false,
                    // pinned: true,
                    //expandedHeight: MediaQuery.of(context).size.height / 4,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Flexiblebar(),
                    )),
                SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 8,
                            right: MediaQuery.of(context).size.width / 8),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (BuildContext context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, right: 30),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.8,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Image.asset(
                                                  images[index % 2],
                                                  fit: BoxFit.fill,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                ),
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Text(
                                                    "This bucket hat has a soft cotton for both genders. Brim offers shade from the sun for the eyes and face. The hat is usually made from fabric such as denim or canvas.",
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                  )),
                                            ],
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            child: FlatButton(
                                                minWidth: 150,
                                                height: 50,
                                                color: Color.fromRGBO(
                                                    224, 116, 82, 1),
                                                onPressed: () {},
                                                child: Text(
                                                  "ADD TO CART",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                      //the hover effect widget
                      MouseRegion(
                        onEnter: _incrementEnter,
                        onHover: _updateLocation,
                        onExit: _incrementExit,
                        child: hover
                            ? RaisedButton(
                                elevation: 2,
                                color: Color.fromRGBO(224, 116, 82, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(6.0),
                                ),
                                onPressed: () {},
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  child: Center(
                                    child: Text(
                                      "SHOP NOW",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                            : RaisedButton(
                                elevation: 2,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(6.0),
                                    side: BorderSide(
                                        color: Color.fromRGBO(40, 98, 122, 1),
                                        width: 2)),
                                onPressed: () {},
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      "SHOP NOW",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //animated fadein where i used starter instead
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: AnimatedCrossFade(
                                firstCurve: Curves.easeInCubic,
                                secondCurve: Curves.easeInCirc,
                                firstChild: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: ClipOval(
                                      child: CircleAvatar(
                                        maxRadius: 125,
                                        child: Image.asset(
                                          'assets/image1.png',
                                          height: 250,
                                          width: 250,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                                secondChild: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _firstChild = !_firstChild;
                                    });
                                  },
                                  child: Container(
                                    height: 250,
                                    width: 250,
                                    child: Image.asset(
                                      'assets/image2.png',
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.amberAccent.shade700,
                                  ),
                                ),
                                crossFadeState: _firstChild
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: Duration(seconds: 2),
                                layoutBuilder: (
                                  Widget topChild,
                                  Key topChildKey,
                                  Widget bottomChild,
                                  Key bottomChildKey,
                                ) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: [
                                      PositionedDirectional(
                                        child: bottomChild,
                                        key: bottomChildKey,
                                        top: 0,
                                      ),
                                      PositionedDirectional(
                                        child: topChild,
                                        key: topChildKey,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, top: 15),
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(18.0),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        "This bucket hat has a soft cotton for both genders. Brim offers shade from the sun for the eyes and face. The hat is usually made from fabric such as denim or canvas.",
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(18.0),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        "Shop With Classic House",
                                        softWrap: true,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(224, 116, 82, 1),
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic),
                                        overflow: TextOverflow.fade,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: Text(
                          "Featured Products",
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(height: 70),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 13,
                            right: MediaQuery.of(context).size.width / 13),
                        child: GridView.count(
                            crossAxisCount: 4,
                            //scrollDirection: Axis.vertical,
                            //itemCount: newdesignreadywearlist.length,
                            primary: false,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            childAspectRatio: (2 / 2),
                            children: List.generate(
                              8,
                              (index) {
                                return Product(
                                  name: "Nike sneakers",
                                  image: products[index % 8],
                                );
                              },
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 13,
                            right: MediaQuery.of(context).size.width / 13),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/footer1.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text("Fast Delivery",
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "You get your products without delay",
                                              softWrap: true,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontStyle: FontStyle.italic),
                                              overflow: TextOverflow.fade,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/footer2.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text("Quality Goods",
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "100% Original",
                                              softWrap: true,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontStyle: FontStyle.italic),
                                              overflow: TextOverflow.fade,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/footer3.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text("Huge Discount",
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "Lovely percentage disounts on  products",
                                              softWrap: true,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontStyle: FontStyle.italic),
                                              overflow: TextOverflow.fade,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ])),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
