
import 'package:flutter/material.dart';
const KEdgeInsets = EdgeInsets.all(24.0);
const KInputDecoration = InputDecoration(
            hintText: 'Enter same data',
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal:10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(color: Colors.blueAccent, width:1)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
               borderSide: BorderSide(color: Colors.blueAccent,width: 2)
            ),
          );