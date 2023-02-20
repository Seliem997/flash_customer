import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/colors.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_bar_widget.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double currentIndex = 0;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About us',
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: List<Widget>.generate(
              4,
              (index) {
                return CustomContainer(
                  width: 305,
                  height: 144,
                  padding: symmetricEdgeInsets(horizontal: 8),
                  clipBehavior: Clip.hardEdge,backgroundColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/car_blue.png',
                        fit: BoxFit.fill,
                        height: 170,
                        width: 315,
                      ),
                      const CustomContainer(
                        width: 305,
                        height: 144,
                        clipBehavior: Clip.hardEdge,
                        backgroundColor: Color.fromRGBO(22, 22, 22, 0.41),
                      ),
                    ],
                  ),
                );
              },
            ),
            options: CarouselOptions(
              height: (144 / screenHeight) * 100.h,
              initialPage: 0,
              viewportFraction: 0.70,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onScrolled: (value) {
                setState(() {
                  currentIndex = value!;
                });
              },
            ),
          ),
          verticalSpace(12),
          DotsIndicator(
            dotsCount: 4,
            position: currentIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          verticalSpace(24),
          Expanded(
            child: Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: 'About Flash wash',fontWeight: MyFontWeight.semiBold, textSize: MyFontSize.size16,),
                        verticalSpace(8),
                        TextWidget(
                          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size12,
                          color: AppColor.grey,
                          height: 1.5,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: 'Lorem ipsum dolor',fontWeight: MyFontWeight.semiBold, textSize: MyFontSize.size16,),
                        verticalSpace(8),
                        TextWidget(
                          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse ',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size12,
                          color: AppColor.grey,
                          height: 1.5,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
