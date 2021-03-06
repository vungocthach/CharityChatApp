import 'package:chat_app/configs/colorconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var fontFamily = "Roboto";

var fontConfig = TextStyle(
    fontFamily: fontFamily,
    color: cwColorBlack,
    fontWeight: FontWeight.normal,
    fontSize: 13.sp);

var kText10RegularBlack = fontConfig.copyWith(fontSize: 10.sp);

var kText11RegularHintText = fontConfig.copyWith(fontSize: 11.sp, color: cwColorGreyHintText);
var kText11RegularWhite = fontConfig.copyWith(fontSize: 11.sp, color: cwColorWhite);

var kText13BoldBlack = fontConfig.copyWith(fontWeight: FontWeight.bold);
var  kText13RegularNote = kText13BoldBlack.copyWith(fontWeight: FontWeight.normal, color: cwColorGreyNoteText);
var  kText13RegularMain = kText13BoldBlack.copyWith(fontWeight: FontWeight.normal, color: cwColorMain);

var kText15RegularGreyNotetext =
    fontConfig.copyWith(fontSize: 15.sp, color: cwColorGreyNoteText);
var kText15BoldMain = fontConfig.copyWith(fontSize: 15.sp, color: cwColorMain, fontWeight: FontWeight.w600);
var kText15RegularMain = kText15BoldMain.copyWith(fontWeight: FontWeight.w300 );
var kText15MediumBlack = fontConfig.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500);
var kText15RegularBlack = kText15RegularMain.copyWith(color: cwColorBlack);
var kText15RegularRed = kText15BoldMain.copyWith(fontWeight: FontWeight.w300, color: cwColorRed );
var kText15BoldBlack = kText15BoldMain.copyWith(color: cwColorBlack);



var kText16RegularWhite = fontConfig.copyWith(fontSize: 16.sp, color: cwColorWhite);
var kText16BoldBlack = kText16RegularWhite.copyWith(fontWeight: FontWeight.bold, color: cwColorBlack);
var kText16RegularBlack = kText16BoldBlack.copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp);

var kText17SemiboldBlack = fontConfig.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600);
var kText17SemiboldMain = fontConfig.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w500, color: cwColorMain);

var ktext17RegularBlack = fontConfig.copyWith(fontSize: 17.sp);
var ktext17RegularGreyText = fontConfig.copyWith(fontSize: 17.sp, color: cwColorGreyNoteText);

var kText17RegularRed = ktext17RegularBlack.copyWith(color: cwColorRed);
var kText17BoldBlack = kText17SemiboldBlack.copyWith(fontWeight: FontWeight.bold);

var kText18RegularMain = fontConfig.copyWith(fontSize: 18.sp, color: cwColorMain);
var kText18RegularWhite = kText18RegularMain.copyWith(color: cwColorWhite);

var kText20MediumBlack = fontConfig.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600);

var kText22BoldMain = fontConfig.copyWith(
    fontSize: 22.sp,
    fontFamily: "Lobster",
    color: cwColorMain,
    fontWeight: FontWeight.bold);


var kText24MeniumBlack = fontConfig.copyWith(
  fontSize: 24.sp,
  fontWeight: FontWeight.w500
);
var kText24BoldMain = kText22BoldMain.copyWith(fontSize: 24.sp);

var kText24BoldBlack = kText24MeniumBlack.copyWith(fontWeight: FontWeight.bold);
