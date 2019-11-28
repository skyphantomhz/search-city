import 'package:flutter/material.dart';

enum Element {
  background,
  text,
  shadow,
  item,
}

final lightTheme = {
  Element.background: Color(0xFF81B3FE),
  Element.text: Colors.white,
  Element.shadow: Colors.black,
  Element.item: Colors.black
};

final darkTheme = {
  Element.background: Colors.black,
  Element.text: Colors.white,
  Element.shadow: Color(0xFF174EA6),
  Element.item: Colors.white
};
