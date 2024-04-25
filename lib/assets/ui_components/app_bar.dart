// ignore_for_file: prefer_const_constructors

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
  }) : preferredSize = Size.fromHeight(80);

  // const CustomAppBar({
  //   super.key,
  // });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Stack(
          children: [
            Image.asset(
              "lib/assets/images/tarot.jpg",
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
