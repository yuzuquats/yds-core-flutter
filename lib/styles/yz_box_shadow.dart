import 'package:flutter/material.dart';

BoxShadow YZDefaultBoxShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.12),
    spreadRadius: 4,
    blurRadius: 4,
    offset: Offset(0, 2), // changes position of shadow
  );
}
