import 'package:chair_shopping/constant/app_colors.dart';
import 'package:chair_shopping/screens/cart_screen.dart' show CartScreen;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Product Detail Screen
class ProductDetailScreen extends HookWidget {
  const ProductDetailScreen({required this.imagePath,super.key});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = useRef<List<Color>>([AppColors.secondaryColor ,AppColors.descriptionColor,AppColors.primaryColor]);
    final selectedColorNotifier = useValueNotifier<int>(0);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              clipBehavior: Clip.none,
              children: [
            ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                child: Image.asset(imagePath,height: size.height * 0.5,width: double.infinity,fit: BoxFit.cover,)),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top - 10,left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(CupertinoIcons.arrow_left,color: AppColors.primaryColor,)),

                  Text("Product",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.primaryColor),),

                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                      },
                      child: SvgPicture.asset('assets/icons/cart.svg',height: 24,width: 24,)),
                ],
              ),
            ),
            Positioned(
              bottom: -20,
              right: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    maximumSize: Size(50, 50),
                    minimumSize: Size(50, 50),
                  ),
                  onPressed: () {

              }, child: SvgPicture.asset('assets/icons/heart.svg',height: 24,width: 24,colorFilter: ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),)),
            )
          ]),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$115.00",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: AppColors.secondaryColor),),
                Row(
                  children: [
                    Text("Minimal Chair",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.primaryColor),),
                    Spacer(),
                    SvgPicture.asset('assets/icons/rating.svg',height: 16,width: 16,),
                    SizedBox(width: 8,),
                    Text("4.5",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.primaryColor),),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Color Options",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.primaryColor),),
                SizedBox(height: 4,),
                Row(
                  spacing: 4,
                  children: List.generate(colors.value.length, (index) {
                    return InkWell(
                      onTap: () {
                        selectedColorNotifier.value = index;
                      },
                      child: HookBuilder(
                        builder: (BuildContext context) {
                          final selectedColor = useValueListenable<int>(selectedColorNotifier);
                          return Container(
                            decoration: selectedColor == index ? BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colors.value[index],width: 2)
                            ) : null,
                            child: Container(
                              margin: EdgeInsets.all(3),
                              height: selectedColor == index ? 16 : 24,
                              width:  selectedColor == index ? 16 : 24,
                              decoration: BoxDecoration(
                                  color: colors.value[index],
                                  shape: BoxShape.circle
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },),
                ),
                SizedBox(height: 16,),
                Text("Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.primaryColor),),
                SizedBox(height: 8,),
                Text("Oversized cushioning for cozy bedroom corners or reading nooks.",
                style: TextStyle(color: AppColors.descriptionColor),),
                SizedBox(height: 16,),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 4.0,bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30))),
                  maximumSize: Size(size.width * 0.5, 60),
                  minimumSize: Size(size.width * 0.5, 60),
                ),
                onPressed: () {

                }, icon: Icon(Icons.add,color: Colors.white,size: 24,),
                label: Text("Add to Cart",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
