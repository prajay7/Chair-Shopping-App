import 'package:chair_shopping/constant/app_colors.dart';
import 'package:chair_shopping/screens/cart_screen.dart' show CartScreen;
import 'package:chair_shopping/screens/product_detail_screen.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leadingWidth: 30,
        actionsPadding: EdgeInsets.only(right: 8),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: SvgPicture.asset(
            'assets/icons/menu.svg',
            colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              'assets/icons/person.svg',
              height: 16,
              width: 16,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            // ---------------- Search Bar View --------------- //
            SearchBar(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Explore",
                style: TextStyle(fontSize: 24,color: AppColors.primaryColor),
              ),
            ),

            // ----------------------- Horizontal Card View ----------------------- //
            HorizontalItemCardView(),


            // ----------------------- Best Selling ----------------------- //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Best Selling",
                style: TextStyle(fontSize: 24,color: AppColors.primaryColor),
              ),
            ),

            // ----------------------- Best Selling Card View ----------------------- //
            BestSellingCardView()

          ],
        ),
      ),
    );
  }
}

/// Best Selling Card View
class BestSellingCardView extends StatelessWidget {
   BestSellingCardView({
    super.key,
  });

  final List<String> images = ['assets/images/chair.jpeg','assets/images/chair2.jpeg','assets/images/chair3.jpeg','assets/images/chair4.jpeg','assets/images/image5.jpg'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(images.length, (index) {
      return  Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8,
              children: [
                // -------------------- Product Image ---------------------- //
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      images[index],
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )),
                // -------------------- Product Details ---------------------- //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Chair",style: TextStyle(color: AppColors.primaryColor),),
                    Text("Description",style: TextStyle(color: AppColors.descriptionColor),),
                    Text("Rs. 2000",style: TextStyle(color: AppColors.primaryColor),),
                  ],
                ),
                Spacer(),
                // -------------------- Next Button ---------------------- //
                FilledButton(
                    style: FilledButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: AppColors.primaryColor,
                      maximumSize: Size(35, 35),
                      minimumSize: Size(35, 35),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(imagePath: images[index],),));
                    }, child: Icon(CupertinoIcons.arrow_right))

              ],
            ),
          ),
        ),
      );
      },
      ),
    );
  }
}

/// Horizontal Card View
class HorizontalItemCardView extends HookWidget {
  const HorizontalItemCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final images = useRef<List<String>>(['assets/images/chair.jpeg','assets/images/chair2.jpeg','assets/images/chair3.jpeg','assets/images/chair4.jpeg','assets/images/image5.jpg']);
    final isFavorite = useValueNotifier<List<bool>>([false,false,false,false,false]);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(images.value.length, (index) {
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------- Image View -------------------------- //
                    Stack(
                      children: [
                        // ------------------- Image View ----------------- //
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            images.value[index],
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // ------------------- Like Button ----------------- //
                        Positioned(
                          right: 8,
                          top: 8,
                          child: HookBuilder(
                            builder: (BuildContext context) {
                              final isSelected = useValueListenable(isFavorite)[index];
                              return InkWell(
                                onTap: () {
                                  isFavorite.value[index] = !isFavorite.value[index];
                                  isFavorite.value = List.from(isFavorite.value);
                                },
                                child: Container(
                                  // padding: EdgeInsets.fromLTRB(4, 4, 8, 8),
                                  height: 24,
                                  width: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: isSelected ?
                                  SvgPicture.asset(
                                    'assets/icons/heart.svg',
                                    height: 14,
                                    width: 16,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.secondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ) : Icon(Icons.favorite_border_rounded,size: 17.7,),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // ---------------------- Product Name View -------------------------- //
                    Text(
                      "Chair",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                    ),
                
                    // ---------------------- Product Description View -------------------------- //
                    Text("Description", style: TextStyle(color: AppColors.descriptionColor)),
                
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rs. 2000", style: TextStyle(color: AppColors.primaryColor)),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(CupertinoIcons.add, color: Colors.white,size: 15,weight: 1,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Search Bar
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: -5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                prefixIconConstraints: BoxConstraints(
                  maxWidth: 50,
                  minWidth: 50,
                ),
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: 24,
                  width: 24,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
          },
          icon: SvgPicture.asset(
            'assets/icons/cart.svg',
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }
}
