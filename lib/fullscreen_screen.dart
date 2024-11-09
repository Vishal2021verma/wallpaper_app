import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullscreenScreen extends StatefulWidget {
  final String imageUrl;
  const FullscreenScreen({super.key, required this.imageUrl});

  @override
  State<FullscreenScreen> createState() => _FullscreenScreenState();
}

class _FullscreenScreenState extends State<FullscreenScreen> {
  setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.contain,
            ),
          )),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  setWallpaper();
                },
                child: const Text("Set Wallpaper")),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
