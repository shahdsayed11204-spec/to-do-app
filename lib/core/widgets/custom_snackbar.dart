import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'coustom_taxt.dart';

SnackBar customSnack({required String errorMsg,Color? color,IconData? icon}){
return SnackBar(
  padding: EdgeInsets.all(10),
  margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(5)
  ),
  behavior: SnackBarBehavior.floating,
  clipBehavior: Clip.none,
  elevation: 5.0,
  backgroundColor: color ?? Colors.red.shade900,
  content: Row(
    children: [
      Icon(icon ?? CupertinoIcons.info_circle,color: Colors.white,size: 12,),
      Gap(20),
      CustomText(text: errorMsg,size: 11,font: FontWeight.bold,color: Colors.white,),
    ],
  ),
);
}