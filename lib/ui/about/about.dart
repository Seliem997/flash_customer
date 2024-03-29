import 'package:carousel_slider/carousel_slider.dart';
import 'package:change_case/change_case.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../providers/about_provider.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final AboutProvider aboutProvider =
        Provider.of<AboutProvider>(context, listen: false);
    await aboutProvider.getAbout();
    await aboutProvider.getAboutImages();
  }

  @override
  Widget build(BuildContext context) {
    final AboutProvider aboutProvider = Provider.of<AboutProvider>(context,);
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).aboutUs,
      ),
      body: aboutProvider.aboutDataList.isEmpty ||
              aboutProvider.aboutImagesDataList.isEmpty
          ? const DataLoader()
          : Column(
              children: [
                CarouselSlider(
                  items: List<Widget>.generate(
                    aboutProvider.aboutImagesDataList.length,
                    (index) {
                      return CustomContainer(
                        width: 325,
                        height: 188,
                        margin: symmetricEdgeInsets(horizontal: 4),
                        padding: symmetricEdgeInsets(horizontal: 0,vertical: 0),
                        clipBehavior: Clip.hardEdge,
                        backgroundColor: Colors.transparent,
                        child: Stack(
                          children: [
                            Image.network(
                              aboutProvider.aboutImagesDataList[index].image!,
                              fit: BoxFit.fill,
                              // height: 188,
                              width: 335,
                            ),
                            const CustomContainer(
                              width: 305,
                              height: 188,
                              clipBehavior: Clip.hardEdge,
                              backgroundColor: Color.fromRGBO(22, 22, 22, 0.41),
                            ),
                            Padding(
                              padding: symmetricEdgeInsets(
                                  horizontal: 16, vertical: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: aboutProvider
                                        .aboutImagesDataList[index].title!
                                        .toCapitalCase(),
                                    fontWeight: MyFontWeight.semiBold,
                                    textSize: MyFontSize.size14,
                                    color: AppColor.white,
                                  ),
                                  verticalSpace(6),
                                  TextWidget(
                                    text: aboutProvider
                                        .aboutImagesDataList[index]
                                        .description!,
                                    fontWeight: MyFontWeight.regular,
                                    textSize: MyFontSize.size12,
                                    color: AppColor.white,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  options: CarouselOptions(
                    height: (188 / screenHeight) * 100.h,
                    initialPage: 0,
                    viewportFraction: 0.80,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onScrolled: (value) {
                      aboutProvider.setCurrentDotsIndex(value!);
                    },

                  ),
                ),
                verticalSpace(12),
                DotsIndicator(
                  dotsCount: aboutProvider.aboutImagesDataList.length,
                  position: aboutProvider.currentDotsIndex,
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
                    child: ListView.separated(
                      itemCount: aboutProvider.aboutDataList.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: aboutProvider.aboutDataList[0].title!
                                .toCapitalCase(),
                            fontWeight: MyFontWeight.semiBold,
                            textSize: MyFontSize.size19,
                          ),
                          verticalSpace(8),
                          TextWidget(
                            text: aboutProvider.aboutDataList[0].description!,
                            fontWeight: MyFontWeight.regular,
                            textSize: MyFontSize.size16,
                            color: AppColor.grey,
                            height: 1.5,
                          )
                        ],
                      ),
                      separatorBuilder: (context, index) => verticalSpace(3),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
