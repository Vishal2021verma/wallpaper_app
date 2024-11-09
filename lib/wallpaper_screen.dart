import 'dart:ui';

import 'package:flutter/material.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        title: const Text("Wallpapers"),
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) => Container(
                        color: Colors.grey.shade200,
                      ))),
          Align(
            alignment: Alignment.center,
            child: TextButton(onPressed: () {}, child: const Text("Load More")),
          )
        ],
      ),
    );
  }
}
