// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  CustomAppBar(
    this.title, {
    super.key,
  }) : preferredSize = const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Stack(
          children: [
            Image.asset(
              "assets/images/tarot.jpg",
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
