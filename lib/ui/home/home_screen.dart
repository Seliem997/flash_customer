import 'package:flash_customer/ui/home/widgets/widgets.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../services/our_services.dart';
import '../sidebar_drawer/sidebar_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();

    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          CustomContainer(
              width: double.infinity,
              padding: EdgeInsets.zero,
              child: Image.asset('assets/images/home_mapping.png',
                  fit: BoxFit.cover)),
          Column(
            children: [
              Padding(
                padding: onlyEdgeInsets(top: 68, start: 24, end: 24),
                child: buildHeader(
                    context: context,
                    onTap: () {
                      globalKey.currentState!.openDrawer();
                    }),
              ),
              verticalSpace(15),
              const SavedLocationExpanded(),
              const Spacer(),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: onlyEdgeInsets(end: 24),
                    child: CustomSizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/locationSpot.png'),
                    ),
                  )),
              verticalSpace(32),
              DefaultButton(
                width: 294,
                height: 56,
                text: 'Wash',
                fontSize: 28,
                fontWeight: MyFontWeight.bold,
                onPressed: () {},
              ),
              verticalSpace(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButton(
                    width: 140,
                    height: 38,
                    backgroundColor: AppColor.buttonGrey,
                    text: 'Products',
                    textColor: AppColor.black,
                    onPressed: () {},
                    fontWeight: MyFontWeight.medium,
                    fontSize: MyFontSize.size14,
                  ),
                  horizontalSpace(12),
                  DefaultButton(
                    width: 140,
                    height: 38,
                    backgroundColor: AppColor.buttonGrey,
                    text: 'Other Services',
                    textColor: AppColor.black,
                    onPressed: () {
                      navigateTo(
                        context,
                        const OurServices(),
                      );
                    },
                    fontWeight: MyFontWeight.medium,
                    fontSize: MyFontSize.size14,
                  ),
                ],
              ),
              verticalSpace(14),
            ],
          ),
        ],
      ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }

  Row buildHeader({required BuildContext context, onTap}) {
    return Row(
      children: [
        CustomSizedBox(
          width: 24,
          height: 24,
          onTap: onTap,
          child: SvgPicture.asset('assets/svg/menu.svg'),
        ),
        horizontalSpace(122),
        CustomSizedBox(
            width: 67, height: 64, child: Image.asset('assets/images/logo.png'))
      ],
    );
  }
}
