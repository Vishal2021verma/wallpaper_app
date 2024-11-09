import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullscreen_screen.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  List images = [];
  int pageNumber = 1;
  fetchPhotos() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=80&page=$pageNumber"),
        headers: {
          "Authorization":
              "ecssEpk0roCo9ZXodoSPmr3ogLg9j9CpRyyNaVIk57gPAduOhaq4sXXX"
        }).then((onValue) {
      Map result = jsonDecode(onValue.body);
      setState(() {
        images.addAll(result["photos"]);
      });
    });
  }

  loadMore() {
    pageNumber = pageNumber + 1;
    setState(() {});
    fetchPhotos();
  }

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

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
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullscreenScreen(
                                      imageUrl: images[index]['src']
                                          ['large2x'])));
                        },
                        child: Container(
                          color: Colors.grey.shade200,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  loadMore();
                },
                child: const Text("Load More")),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
