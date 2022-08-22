import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//color
const green = Color(0xFF377D71);
const pink = Color(0xffFBA1A1);

//space(SizedBox)
const spaceW8 = SizedBox(width: 8);
const spaceW16 = SizedBox(width: 16);
const spaceH8 = SizedBox(height: 8);
const spaceH16 = SizedBox(height: 16);
const spaceH24 = SizedBox(height: 24);
const spaceH32 = SizedBox(height: 32);

//Datetimeフォーマット
final now = DateTime.now(); //時間含む
final nowDate = DateTime(now.year, now.month, now.day); //年月日のみ
final formatDefault = DateFormat('yyyy-MM-dd');
final formatDays = DateFormat('Md');
final formatYear = DateFormat('y');

//アイコン
const nextIcon = Icon(
  Icons.navigate_next,
  color: pink,
);
const redeemIcon = Icon(
  Icons.redeem,
  color: pink,
);
