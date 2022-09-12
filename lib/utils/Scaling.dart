import 'package:flutter/material.dart';

const guidedWidth = 360;
const guidedHeight = 776;

double deviceHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double? normalizedHeight(BuildContext context,size){
  return ((deviceHeight(context)/guidedHeight)*size);
}

double? normalizedWidth(BuildContext context,size){
  return ((deviceWidth(context)/guidedWidth)*size);

}