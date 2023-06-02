import 'package:flutter/material.dart';

import '../../controller/apiOper.dart';
import '../../models/categoryModel.dart';
import '../../models/photosModel.dart';
import '../widgets/categoryBlock.dart';
import '../widgets/customAppbar.dart';
import '../widgets/searchBar.dart';
import 'fullscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PhotosModel> trendingWallList = [];
  List<CategoryModel> CatModList = [];
  bool isLoading = true;
  int page = 1;
  GetCatDetails() async {
    CatModList = await ApiOperation.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  getTrendingWallpapers() async {
    trendingWallList = await ApiOperation.getTradingWallpaper();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTrendingWallpapers();
    GetCatDetails();
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CatModList.length == 0
                  ? Container(
                      height: 5,
                      width: 5,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.black.withOpacity(0.5),
                      )),
                    )
                  : SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CatModList.length,
                        itemBuilder: (BuildContext context, index) => CatBlock(
                          categoryImgSrc: CatModList[index].catImgUrl,
                          categoryName: CatModList[index].catName,
                        ),
                      ),
                    ),
            ),
            trendingWallList.length == 0
                ? Container(
                    child: Center(
                        child: CircularProgressIndicator(
                    color: Colors.black.withOpacity(0.5),
                  )))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 400,
                                crossAxisCount: 2,
                                mainAxisSpacing: 13,
                                crossAxisSpacing: 13),
                        itemCount: trendingWallList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreen(
                                              imgUrl: trendingWallList[index]
                                                  .imgsrc)));
                                },
                                child: Hero(
                                  tag: trendingWallList[index].imgsrc,
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
                                        trendingWallList[index].imgsrc,
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
