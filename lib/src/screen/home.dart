import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/src/model/User.dart';
import 'package:swipe_app/src/provider/user.dart';
import 'package:swipe_app/src/style/hex_color.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange", "Orange","Orange","Orange","Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.orange
  ];

  bool nope = false;
  bool liked = false;
  bool superLiked = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<User> users = await UserProvider().getUsers();
      populateSwipeItems(users);
    });
    

    super.initState();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey,
    body: Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return ListView(
          children: [
            const SizedBox(height: 15.0),
            SizedBox(
              height: 60.0,
              child: Image.asset('assets/images/tinder.png')
            ),
            const SizedBox(height: 35.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(0.0),
              height: MediaQuery.of(context).size.height * 0.7,
              // decoration: BoxDecoration(
              //   border: Border.all(width: 1.0, color: Colors.grey.shade300),
              //   borderRadius: const BorderRadius.all(Radius.circular(25.0))
              // ),
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              foregroundDecoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                  Colors.transparent,
                                  Colors.black54
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0, 0.9],
                                ),
                              ),
                              child: Image.asset('assets/images/${userProvider.users[index].image}')),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          child: Container(
                            height: 130,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text('${userProvider.users[index].name}, ${userProvider.users[index].age}',
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 25),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Flexible(
                                  child: Text(userProvider.users[index].location,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Flexible(
                                  child: Text('${userProvider.users[index].distance} miles away',
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          maintainSize: true, 
                          maintainAnimation: true,
                          maintainState: true,
                          visible: nope,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 3.0, color: HexColor('#dd6157')),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Text('NOPE',
                                style: TextStyle(
                                  color: HexColor('#dd6157'),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                          ),
                        ),
                        Visibility(
                          maintainSize: true, 
                          maintainAnimation: true,
                          maintainState: true,
                          visible: superLiked,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 3.0, color: HexColor('#1ca9fd')),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Text('SUPERLIKE',
                                style: TextStyle(
                                  color: HexColor('#1ca9fd'),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                          ),
                        ),
                        Visibility(
                          maintainSize: true, 
                          maintainAnimation: true,
                          maintainState: true,
                          visible: liked,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 3.0, color: HexColor('#87f19d')),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Text('LIKE',
                                style: TextStyle(
                                  color: HexColor('#87f19d'),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                          ),
                        )
                      ],
                    )
                  );
                },
                onStackFinished: () {
                  _scaffoldKey.currentState?.showSnackBar(SnackBar(
                    content: Text("Stack Finished"),
                    duration: Duration(seconds: 2),
                  ));
                },
                itemChanged: (SwipeItem item, int index) {
                  print("item: $index index: $index");
                },
                upSwipeAllowed: true,
                fillSpace: true,
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => {
                    setState(() {
                      nope = true;
                    }),
                    Timer(const Duration(milliseconds: 200), () => setState(() {
                      nope = false;
                    })),
                    _matchEngine.currentItem?.nope(),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: HexColor('#f76358')),
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300, //New
                          blurRadius: 25.0,
                          offset: const Offset(0, 25))
                      ],
                    ),
                    child: Icon(Icons.close,
                      size: 50,
                      color: HexColor('#f76358'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {
                    setState(() {
                      superLiked = true;
                    }),
                    Timer(const Duration(milliseconds: 200), () => setState(() {
                      superLiked = false;
                    })),
                    _matchEngine.currentItem?.superLike(),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: HexColor('#1ca9fd')),
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300, //New
                          blurRadius: 25.0,
                          offset: const Offset(0, 25))
                      ],
                    ),
                    child: Icon(Icons.star,
                      size: 25,
                      color: HexColor('#1ca9fd'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {
                    setState(() {
                      liked = true;
                    }),
                    Timer(const Duration(milliseconds: 200), () => setState(() {
                      liked = false;
                    })),
                    _matchEngine.currentItem?.like()
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: HexColor('#00d085')),
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300, //New
                          blurRadius: 25.0,
                          offset: const Offset(0, 25))
                      ],
                    ),
                    child: Icon(Icons.favorite,
                      size: 45,
                      color: HexColor('#00d085'),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }
    ),
    backgroundColor: Colors.grey.shade100,
    );
  }

  void populateSwipeItems(List<User> users) {
    // _swipeItems.clear();
    for (int i = 0; i < users.length; i++) {
      _swipeItems.add(SwipeItem(
        content: Text("Nope ${users[i].name}"),
        likeAction: () {
          // setState(() {
          //   liked = true;
          // });
          // var timer = Timer(const Duration(seconds: 1), () => setState(() {
          //   liked = false;
          // }));
          // timer.cancel();
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
            content: Text("Liked ${users[i].name}"),
            duration: const Duration(milliseconds: 500),
          ));
          // setState(() {
          //   liked = false;
          // });
        },
        nopeAction: () {
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
            content: Text("Nope ${users[i].name}"),
            duration: const Duration(milliseconds: 500),
          ));
                   },
        superlikeAction: () {
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
            content: Text("Superliked ${users[i].name}"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        onSlideUpdate: (SlideRegion? region) async {
          print("Region $region");
        }));
  }

  _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }
}