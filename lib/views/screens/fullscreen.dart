import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

// var file = await DefaultCacheManager().getSingleFile(url);
class FullScreen extends StatefulWidget {
  String imgUrl;
  FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool result = false;
  Future<void> setHomeWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
  }

  Future<void> setLockWallpaper() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
  }

  void _showAlertDialog(BuildContext context) async {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Set as Wallpaper"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: false,
            onPressed: () async {
              await setHomeWallpaper();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Home Screen      '),
          ),
          CupertinoDialogAction(
            isDestructiveAction: false,
            onPressed: () async {
              await setLockWallpaper();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Lock Screen         '),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imgUrl), fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          alignment: Alignment.bottomCenter,
          child: CupertinoButton(
              color: Colors.grey.withOpacity(0.7),
              onPressed: () async {
                _showAlertDialog(context);
              },
              child: Text(
                "Set Wallpaper",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
