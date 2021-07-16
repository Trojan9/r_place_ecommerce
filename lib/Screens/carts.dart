import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:r_place/utils/pinnedbar.dart';
import 'package:webscrollbar/webscrollbar.dart';

const int DEFAULT_SCROLL_SPEED = 130;
const int DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS = 250;
var images = ["assets/image1.png", "assets/image2.png"];
var cardcolors = [
  Color.fromRGBO(0, 0, 0, 0.94),
  Color.fromRGBO(224, 116, 82, 1),
  Color.fromRGBO(40, 98, 122, 1)
];
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

class Cartproducts extends StatefulWidget {
  const Cartproducts({Key key}) : super(key: key);

  @override
  _CartproductsState createState() => _CartproductsState();
}

class _CartproductsState extends State<Cartproducts> {
  final cvController = TextEditingController();
  final cardController = TextEditingController();
  final expController = TextEditingController();
  final nameController = TextEditingController();
  bool hover = false;
  int cartnumber = 0;
  var chosepayment = [false, false];
  int cardindex = 0;
  ScrollController controller = ScrollController();
  ScrollController controller2 = ScrollController();
  final int scrollSpeed = DEFAULT_SCROLL_SPEED;
  final Curve curve = Curves.linear;
  final int scrollAnimationLength = DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS;
  double _scroll = 0;
  double _scroll2 = 0;
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

  bool changepin = false;
  @override
  void initState() {
    super.initState();
    // controller2.addListener(() {
    //   if (mounted) {
    //     if (controller2.position.activity is IdleScrollActivity) {
    //       _scroll2 = controller2.position.extentBefore;
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    controller2.dispose();
    controller.dispose();

    super.dispose();
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
                  // expandedHeight: 150.0,
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
                ),
                SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 13,
                      right: MediaQuery.of(context).size.width / 13,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Payment",
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                7),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (cardindex > 0) {
                                          setState(() {
                                            cardindex -= 1;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(150),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 1),
                                          child: Icon(Icons.arrow_back_ios,
                                              size: 20, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Container(
                                        // height: MediaQuery.of(context).size.height / 3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: cardcolors[cardindex % 3]

                                                // changes position of shadow
                                                ),
                                          ],
                                          gradient: RadialGradient(
                                              // begin: Alignment.topRight,
                                              // end: Alignment.bottomLeft,
                                              radius: 1.8,
                                              center: Alignment.bottomLeft,
                                              colors: [
                                                Color.fromRGBO(
                                                    255, 255, 255, 0.3),
                                                Color.fromRGBO(
                                                    255, 255, 255, 0),
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 15,
                                                right: 15,
                                                bottom: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Barter",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        )),
                                                    Image.asset(
                                                      "Group111.png",
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        height: 100,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: 4,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    index) {
                                                              return Container(
                                                                height: 90,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    20,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        //padding: const EdgeInsets.only(right: 5),
                                                                        itemCount:
                                                                            4,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 2.0),
                                                                            child:
                                                                                CircleAvatar(
                                                                              radius: 6,
                                                                              backgroundColor: Colors.black,
                                                                            ),
                                                                          );
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        // SizedBox(width: 10,),
                                                        Text("4567",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            8,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "CARDHOLDER NAME",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Text(
                                                              "John Doe",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              maxLines: 2,
                                                            ),
                                                          ],
                                                        )),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "EXPIRE DATE",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          "05 / 21",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {}),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {}),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                7),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          cardindex += 1;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(150),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 1),
                                          child: Icon(Icons.arrow_forward_ios,
                                              size: 20, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: RaisedButton(
                                        elevation: 2,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(6.0),
                                            side: BorderSide(
                                                color:
                                                    cardcolors[cardindex % 3],
                                                width: 2)),
                                        onPressed: () {
                                          setState(() {
                                            chosepayment[0] = !chosepayment[0];
                                            chosepayment[1] = false;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          width: 150,
                                          color: Colors.white,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      chosepayment[0]
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .radio_button_off,
                                                      size: 25,
                                                      color: cardcolors[
                                                          cardindex % 3],
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        chosepayment[0] =
                                                            !chosepayment[0];
                                                        chosepayment[1] = false;
                                                      });
                                                    }),
                                                Text(
                                                  "Credit Card",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: 10,
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: RaisedButton(
                                        elevation: 2,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(6.0),
                                            side: BorderSide(
                                                color:
                                                    cardcolors[cardindex % 3],
                                                width: 2)),
                                        onPressed: () {
                                          setState(() {
                                            chosepayment[1] = !chosepayment[1];
                                            chosepayment[0] = false;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          width: 150,
                                          color: Colors.white,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      chosepayment[1]
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .radio_button_off,
                                                      size: 25,
                                                      color: cardcolors[
                                                          cardindex % 3],
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        chosepayment[1] =
                                                            !chosepayment[1];
                                                        chosepayment[0] = false;
                                                      });
                                                    }),
                                                Text(
                                                  "Pay Pal",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: cardController,
                                      maxLength: 5,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          focusedBorder: new OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: cardcolors[
                                                      cardindex % 3])),
                                          border: new OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      94, 94, 94, 1))),
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          labelText: 'Card Number',
                                          hintText: "0000 0000 0000 0000"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: cardController,
                                      maxLength: 5,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.person,
                                            size: 17,
                                            color: Color.fromRGBO(
                                                125, 125, 125, 1),
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: cardcolors[
                                                      cardindex % 3])),
                                          border: new OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      94, 94, 94, 1))),
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          labelText: 'Card Holder Name',
                                          hintText: "Johndoe"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            controller: cardController,
                                            maxLength: 5,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.calendar_today_sharp,
                                                  size: 17,
                                                  color: Color.fromRGBO(
                                                      125, 125, 125, 1),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: cardcolors[
                                                                cardindex %
                                                                    3])),
                                                border: new OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            94, 94, 94, 1))),
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                labelText: 'Exp Date',
                                                hintText: "12/23"),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              width: 10,
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            controller: cardController,
                                            maxLength: 5,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.info_rounded,
                                                  size: 17,
                                                  color: Color.fromRGBO(
                                                      125, 125, 125, 1),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: cardcolors[
                                                                cardindex %
                                                                    3])),
                                                border: new OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            94, 94, 94, 1))),
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                labelText: 'CVV',
                                                hintText: "233"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                    ),
                                    RaisedButton(
                                        elevation: 2,
                                        color: cardcolors[cardindex % 3],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(6.0),
                                        ),
                                        onPressed: () {},
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          child: Center(
                                            child: Text(
                                              "Complete Order",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(
                        //     flex: 1,
                        //     child: SizedBox(
                        //       width: 10,
                        //     )),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Order",
                                        softWrap: true,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: 25,
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                WebScrollBar(
                                  controller: controller2,
                                  visibleHeight: 30,
                                  animationLength: 10,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.green[50])),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, left: 18, right: 18),
                                      child: ListView.builder(
                                          controller: controller2,
                                          // physics: NeverScrollableScrollPhysics(),
                                          // primary: false,
                                          // shrinkWrap: true,
                                          itemCount: 10,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors
                                                              .green[50])),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                              ),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  5,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  15,
                                                              child:
                                                                  Image.asset(
                                                                "assets/products/1.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    6,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: SizedBox(
                                                              width: 8,
                                                            )),
                                                        Expanded(
                                                          flex: 6,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Nike Airmax Sneakers",
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 2,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          26.0,
                                                                      top: 8),
                                                                  child: Text(
                                                                    "\₦ 12,000",
                                                                    softWrap:
                                                                        true,
                                                                    maxLines: 2,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          22.0,
                                                                      top: 8),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                          icon: Icon(Icons
                                                                              .horizontal_rule_rounded),
                                                                          onPressed:
                                                                              () {
                                                                            if (cartnumber >
                                                                                0) {
                                                                              setState(() {
                                                                                cartnumber -= 1;
                                                                              });
                                                                            }
                                                                          }),
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "$cartnumber",
                                                                          softWrap:
                                                                              true,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                          overflow:
                                                                              TextOverflow.fade,
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                          icon: Icon(Icons
                                                                              .add),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              cartnumber += 1;
                                                                            });
                                                                          }),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(),
                                                                    IconButton(
                                                                        icon: Icon(Icons
                                                                            .delete),
                                                                        onPressed:
                                                                            () {}),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
