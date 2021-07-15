import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:r_place/utils/pinnedbar.dart';
import 'package:r_place/utils/flexiblebar.dart';
import 'package:webscrollbar/webscrollbar.dart';

const int DEFAULT_SCROLL_SPEED = 130;
const int DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS = 250;
var images = ["assets/image1.png", "assets/image2.png"];

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ScrollController controller = ScrollController();
  final int scrollSpeed = DEFAULT_SCROLL_SPEED;
  final Curve curve = Curves.linear;
  final int scrollAnimationLength = DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS;
  double _scroll = 0;
  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      if (controller.position.activity is IdleScrollActivity) {
        _scroll = controller.position.extentBefore;
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
                    title: PreferredSize(
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
                      RaisedButton(
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
                          )),
                      SizedBox(
                        height: 20,
                      )
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
