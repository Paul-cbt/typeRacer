import 'package:coursedefrappe/typeracer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void checking(List spans, int pos, String text) {
  print(text);
  print(pos);
  print(spans[pos].text);
  if (text + " "== spans[pos].text) {
    
    spans[pos] = TextSpan(
        text: spans[pos],
        style: TextStyle(
            color: Colors.green, fontFamily: "Montserrat", fontSize: 20));
  } else {
    print("false");
  }
}
