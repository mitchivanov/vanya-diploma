import 'package:flutter/material.dart';

Offset getWidgetCoordinates(GlobalKey key){
  final RenderBox renderBox =
  key.currentContext!.findRenderObject() as RenderBox;
  return renderBox.localToGlobal(Offset.zero);
}