import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangeureut/constants.dart';
import 'package:hangeureut/providers/news/news_state.dart';
import 'package:hangeureut/providers/profile/profile_provider.dart';
import 'package:hangeureut/providers/profile/profile_state.dart';
import 'package:hangeureut/repositories/news_repository.dart';
import 'package:hangeureut/repositories/restaurant_repository.dart';
import 'package:hangeureut/screens/profile_screen/others_profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../models/news_model.dart';

const boldStyle = TextStyle(
    height: 1,
    fontWeight: FontWeight.w800,
    fontSize: 14,
    fontFamily: 'Suit',
    color: kSecondaryTextColor);

const regularStyle = TextStyle(
    height: 1,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: 'Suit',
    color: kSecondaryTextColor);

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  TextEditingController sendingController = TextEditingController();

  @override
  void dispose() {
    sendingController.dispose();
    super.dispose();
  }

  BoxDecoration rowDecoration(watched) {
    return BoxDecoration(
        color: watched ? Colors.white : const Color(0xfff7f7f7),
        border: Border(
            bottom: BorderSide(
                color: kBorderGreenColor.withOpacity(0.2), width: 0.5)));
  }

  Widget type1News(i) {
    bool isFriends = false;
    List friends = context.watch<ProfileState>().user.followings;
    for (var friend in friends) {
      if (friend["id"] == i.content.userId) isFriends = true;
    }
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            screen: OthersProfilePage(userId: i.content.userId));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 65,
        decoration: rowDecoration(i.watched),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 33,
                  ),
                  Text(
                    "${profileIcons[i.content.userIcon]} ",
                    style: regularStyle,
                  ),
                  Text(
                    i.content.userName,
                    style: boldStyle,
                  ),
                  const Text(
                    "님이 내 식탁을 찜했어요!",
                    style: regularStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 26.0),
                child: GestureDetector(
                  onTap: () {
                    isFriends
                        ? null
                        : context.read<ProfileProvider>().setFriends(
                            i.content.userId,
                            i.content.userName,
                            i.content.userIcon);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 71,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: isFriends ? Color(0xffe5e5e5) : kBasicColor,
                    ),
                    child: Center(
                      child: Text(
                        isFriends ? "구독중" : "찜하기",
                        style: regularStyle.copyWith(
                            fontWeight:
                                isFriends ? FontWeight.w600 : FontWeight.w700,
                            color:
                                isFriends ? kSecondaryTextColor : Colors.white,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  Widget type2News(i) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            screen: OthersProfilePage(userId: i.content.userId));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 65,
        decoration: rowDecoration(i.watched),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 33,
            ),
            Text(
              "${profileIcons[i.content.userIcon]} ",
              style: regularStyle,
            ),
            Text(
              i.content.userName,
              style: boldStyle,
            ),
            Text(
              "님이 나의 ${i.content.resName} 기록을 좋아했어요",
              style: regularStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget type3News(i) {
    return Container(
      height: 84,
      decoration: rowDecoration(i.watched),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 33,
          ),
          Text(
            i.content.title,
            style: boldStyle,
          ),
          Text(
            i.content.content,
            style: regularStyle,
          )
        ],
      ),
    );
  }

  Widget recommendWidget() {
    return Container(
      height: 160,
      decoration: BoxDecoration(color: Color(0xffE8EBDB)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Text(
                  "💬 아니, ",
                  style: regularStyle,
                ),
                Text(
                  "여기가 없다고?!",
                  style: boldStyle,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 41,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(17)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: sendingController,
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight: 10,
                      cursorColor: kBasicColor,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        hintText: "한그릇에 맛집을 추천해주세요.",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            height: 1,
                            fontFamily: 'Suit',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kSecondaryTextColor.withOpacity(0.5)),
                      ),
                      style: const TextStyle(
                          height: 1,
                          fontFamily: 'Suit',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kSecondaryTextColor),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      print(sendingController.text);
                      if (sendingController.text != "") {
                        context.read<RestaurantRepository>().sendNewRes(
                            content: sendingController.text,
                            userId: context.read<ProfileState>().user.id);
                        sendingController.clear();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 11.5),
                      child: Image.asset(
                        "images/icons/send.png",
                        width: 26.5,
                        height: 26.5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> newsWidget(news) {
    List<Widget> result = [
      recommendWidget(),
      SizedBox(
        height: 53,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 27),
        child: Text(
          "알림",
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
              color: kBasicColor,
              fontFamily: 'Suit',
              height: 1),
        ),
      )
    ];
    for (var i in news) {
      if (i == null) break;
      if (i.type == 0) {
        result.add(type1News(i));
      } else if (i.type == 1) {
        result.add(type2News(i));
      } else {
        result.add(type3News(i));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<News> news = context.watch<NewsState>().newsList;
    print(news);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: newsWidget(news),
        ),
      ),
    );
  }
}