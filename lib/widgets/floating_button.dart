import 'package:flutter/material.dart';
import 'package:hangeureut/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ReviewFloatingButton extends StatelessWidget {
  ReviewFloatingButton({
    Key? key,
    required this.buttonColor,
    required this.onTap,
  }) : super(key: key);
  Color buttonColor;
  final onTap;

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(56),
              color: kSecondaryTextColor),
          child: Center(
            child: Icon(
              MdiIcons.pencilOutline,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}

// showModalBottomSheet(
//     context: context,
//     useRootNavigator: true,
//     builder: (BuildContext context) {
//       return Container(
//         height: 100,
//       );
//     });

//   RawMaterialButton(
//   onPressed: () {
//
//   },
//   elevation: 2.0,
//   fillColor: buttonColor,
//   child: Icon(
//   MdiIcons.pencilOutline,
//   color: Colors.white,
//   size: 30.0,
//   ),
//   padding: EdgeInsets.all(12.0),
//   shape: CircleBorder(),
//   );
