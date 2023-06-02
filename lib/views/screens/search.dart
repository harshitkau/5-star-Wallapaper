import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wallpaper_guru/models/photosModel.dart';

import '../../controller/apiOper.dart';
import '../widgets/customAppbar.dart';
import '../widgets/searchBar.dart';
import 'fullscreen.dart';

class Search extends StatefulWidget {
  String query;
  Search({super.key, required this.query});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> searchResults = [];
  bool imageShow = false;
  getSearchResult() async {
    setState(() {
      imageShow = true;
    });
    searchResults = await ApiOperation.searchWallpaper(widget.query);
    setState(() {
      imageShow = false;
    });
    if (searchResults.length == 0) {
      _showAlertDialog(context);
    }
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'No Wallpaper Found',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        content: const Text(
          'Please Search Another Category',
          style: TextStyle(fontSize: 15),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: "⭐5 STAR",
          word2: " Wallpaper⭐",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SearchBar(),
            ),
            imageShow
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 400,
                                crossAxisCount: 2,
                                mainAxisSpacing: 13,
                                crossAxisSpacing: 13),
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreen(
                                              imgUrl: searchResults[index]
                                                  .imgsrc)));
                                },
                                child: Hero(
                                  tag: searchResults[index].imgsrc,
                                  child: Container(
                                    height: 700,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        searchResults[index].imgsrc,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
          ],
        ),
      ),
    );
  }
}
