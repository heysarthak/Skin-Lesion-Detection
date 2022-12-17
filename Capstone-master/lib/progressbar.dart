

import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 10),
      child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.redAccent)));
}

Container linearProgress() {
  return Container(
    child: const LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.purple)),
    padding: const EdgeInsets.only(bottom: 10),
  );
}