import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/loading.json');
  }
}
