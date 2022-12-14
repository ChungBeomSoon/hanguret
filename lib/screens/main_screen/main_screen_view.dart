import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile/profile_provider.dart';
import '../../widgets/profile_icon_box.dart';

class WelcomeDialog extends StatefulWidget {
  WelcomeDialog({Key? key, required this.onMoreTap}) : super(key: key);
  final onMoreTap;

  @override
  State<WelcomeDialog> createState() => _WelcomeDialogState();
}

class _WelcomeDialogState extends State<WelcomeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 300,
          height: 511,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 46,
                  ),
                  ProfileIconBox(content: "๐"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "๋ฐ๊ฐ์์!",
                    style: TextStyle(
                        color: kSecondaryTextColor,
                        fontFamily: 'Suit',
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "๋ฐฅ์น๊ตฌ๋ฅผ ๋งบ์ผ๋ฉด ์๋ก์ ํ๋ ์ด์ค๋ฅผ ํ์ธํ๊ณ ,",
                    style: TextStyle(
                        color: kSecondaryTextColor,
                        fontFamily: 'Suit',
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "์น๊ตฌ์ ์์ฌ ๊ธฐ๋ก์ ๊ตฌ๊ฒฝํ  ์ ์์ต๋๋ค.",
                    style: TextStyle(
                        color: kSecondaryTextColor,
                        fontFamily: 'Suit',
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30,
                    width: 250,
                    child: Divider(
                      color: kBorderGreenColor.withOpacity(0.5),
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onMoreTap();
                      // context.read<ProfileProvider>().setLogin();
                      //Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Text(
                          "์น๊ตฌ ๋ ์ฐพ๊ธฐ",
                          style: TextStyle(
                              color: kSecondaryTextColor,
                              fontFamily: 'Suit',
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: kSecondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ProfileProvider>().setLogin();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 114,
                      height: 44,
                      decoration: BoxDecoration(
                          color: kBasicColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          "๋ค์์ ํ๊ธฐ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
