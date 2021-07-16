import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Product extends StatefulWidget {
  final image;
  final name;
  const Product({Key key, this.image, this.name}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28),
          child: Container(
            width: MediaQuery.of(context).size.width / 7,
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      "${widget.name}",
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("\₦ 20,000",
                          softWrap: true,
                          maxLines: 1,
                          //overflow: TextOverflow.ellipsis,\
                          style: TextStyle(fontSize: 12)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text("\₦ 10,000",
                          softWrap: true,
                          maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 8)),
                    ),
                    Expanded(
                      flex: 4,
                      child: RaisedButton(
                          elevation: 2,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(57, 137, 170, 1),
                                  width: 2)),
                          onPressed: () {},
                          child: Container(
                            height: 30,
                            width: 100,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "ADD CART",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(57, 137, 170, 1)),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: 4,
                      size: 15.0,
                      isReadOnly: true,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.blur_on,
                      color: Color.fromRGBO(245, 211, 108, 1),
                      borderColor: Color.fromRGBO(245, 211, 108, 1),
                      spacing: 0.0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // begin: Alignment.topRight,
                // end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(57, 137, 170, 1),
                  Color.fromRGBO(224, 116, 82, 1),
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            constraints: BoxConstraints(
              minWidth: 40,
              minHeight: 13,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(
                //mynewCartlength == null ? "0" :
                "20%",
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
    );
  }
}
