import 'package:flash_customer/ui/home/widgets/widgets.dart';
import 'package:flash_customer/ui/user/register/register.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/cache_helper.dart';
import '../../utils/styles/colors.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../monthly_pkg/monthly_pkg.dart';
import '../services/other_services.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../vehicles/vehicles_type.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    final bool loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          CustomContainer(
              width: double.infinity,
              padding: EdgeInsets.zero,
              child: Image.asset('assets/images/home_mapping.png',
                  fit: BoxFit.cover)),
          // GoogleMap(),
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
              Visibility(
                visible: loggedIn,
                child: const SavedLocationExpanded(),
              ),
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
                onPressed: loggedIn
                    ? () {
                  navigateTo(context, const VehicleTypes());
                }
                    : () {
                        buildLoginDialog(context);
                      },
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
                    onPressed: loggedIn
                        ? () {}
                        : () {
                            buildLoginDialog(context);
                          },
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
                    onPressed: loggedIn
                        ? () {
                            navigateTo(
                              context,
                              const OtherServices(),
                            );
                          }
                        : () {
                            buildLoginDialog(context);
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

  Future<dynamic> buildLoginDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Padding(
            padding: EdgeInsets.all(20.0),
            child: TextWidget(
              text: 'Please Log in First!',
            ),
          ),
          actions: [
            Padding(
              padding: symmetricEdgeInsets(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButton(
                    width: 90,
                    height: 30,
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColor.lightRed,
                  ),
                  horizontalSpace(20),
                  DefaultButton(
                    width: 100,
                    height: 30,
                    text: 'Log in',
                    onPressed: () {
                      Navigator.pop(context);
                      navigateTo(context, const RegisterPhoneNumber());
                    },
                    backgroundColor: AppColor.primary,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Row buildHeader({required BuildContext context, onTap}) {
    final bool loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
    return Row(
      children: [
        Visibility(
          visible: loggedIn,
          child: CustomSizedBox(
            width: 24,
            height: 24,
            onTap: onTap,
            child: SvgPicture.asset('assets/svg/menu.svg'),
          ),
        ),
        horizontalSpace(122),
        CustomSizedBox(
            width: 67, height: 64, child: Image.asset('assets/images/logo.png'))
      ],
    );
  }
}
