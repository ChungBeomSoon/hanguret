import 'package:flutter/material.dart';
import 'package:hangeureut/constants.dart';
import 'package:hangeureut/repositories/restaurant_repository.dart';
import 'package:hangeureut/restaurants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../restaurant_detail_screen/restaurant_detail_page.dart';

class SearchForReviewPage extends StatefulWidget {
  const SearchForReviewPage({Key? key}) : super(key: key);
  static String routeName = "/search_for_review_page";

  @override
  State<SearchForReviewPage> createState() => _SearchForReviewPageState();
}

class _SearchForReviewPageState extends State<SearchForReviewPage> {
  String searchTerm = "";
  List relatedResults = [];
  Map? selected;
  List? near;
  List? popular;

  Future<List> getRelated(val) async {
    List results = [];
    if (val == "") return results;
    for (var e in restaurantsDB) {
      final String name = e["name"]!.toString();

      if (name.contains(val)) {
        int searchIndex = name.indexOf(val);
        final nameList = [
          name.substring(0, searchIndex),
          val,
          name.substring((searchIndex + val.length).toInt())
        ];
        Map newE = {...e, "nameList": nameList};
        results.add(newE);
      }
    }
    return results;
  }

  Color getTextColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
// the color to return when button is in pressed, hovered, focused state
      return Colors.white.withOpacity(0.1);
    }
// the color to return when button is in it's normal/unfocused state
    return Colors.transparent;
  }

  Future<void> getReco() async {
    Map<String, List>? recommends =
        await context.read<RestaurantRepository>().getResForReview();
    if (recommends != null) {
      near = recommends["near"];
      popular = recommends["popular"];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getReco();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: kBasicColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 220.0, left: 30, right: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white)),
                            ),
                            child: TextFormField(
                              onChanged: (val) async {
                                searchTerm = val;
                                relatedResults = await getRelated(val);
                                setState(() {});
                              },
                              style: TextStyle(
                                  fontFamily: 'Suit',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "????????? ????????? ??????????????????.",
                                  hintStyle: TextStyle(
                                      fontFamily: 'Suit',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: Image.asset(
                            "images/icons/searchbig.png",
                            width: 33,
                            height: 33,
                          ),
                        )
                      ],
                    ),
                  ),
                  searchTerm.length == 0
                      ? SizedBox(
                          height: 133,
                        )
                      : Container(
                          height: 258,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: relatedResults.map((e) {
                                  return Container(
                                    height: 39,
                                    padding: EdgeInsets.zero,
                                    child: TextButton(
                                      onPressed: () {
                                        pushNewScreen(
                                          context,
                                          screen: RestaurantDetailPage(
                                            resId: e["id"],
                                            option: false,
                                          ),
                                          withNavBar: true,
                                        );
                                      },
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      Colors.transparent),
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  getTextColor)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            //?
                                            width: 22,
                                          ),
                                          Text(
                                            e["nameList"][0],
                                            style: TextStyle(
                                                fontFamily: 'Suit',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            e["nameList"][1],
                                            style: TextStyle(
                                                fontFamily: 'Suit',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            e["nameList"][2],
                                            style: TextStyle(
                                                fontFamily: 'Suit',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 39,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                  ),
                  child: Text(
                    "?????? ????????? ???????????????????",
                    style: TextStyle(
                        fontFamily: 'Suit',
                        color: kSecondaryTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        height: 1),
                  ),
                ),
                popular == null || near == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 21.0, bottom: 60),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: near!
                                    .map((e) =>
                                        ResTile(res: e, type: "?????? ?????? ?????????"))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: popular!
                                    .map((e) =>
                                        ResTile(res: e, type: "?????? ?????? ?????????"))
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResTile extends StatelessWidget {
  ResTile({Key? key, required this.res, required this.type}) : super(key: key);

  Map res;
  String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          pushNewScreen(context,
              screen: RestaurantDetailPage(
                  resId: res["resId"].toString(), option: false));
        },
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  res["imgUrl"],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                left: 12,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: regularTextStyle.copyWith(fontSize: 10),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      res["name"],
                      style: eBoldTextStyle.copyWith(fontSize: 15),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
