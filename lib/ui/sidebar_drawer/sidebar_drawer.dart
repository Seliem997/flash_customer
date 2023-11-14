import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_customer/ui/sidebar_drawer/widgets/logout_dialog.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/user_provider.dart';
import '../../utils/styles/colors.dart';
import '../../utils/font_styles.dart';
import '../about/about.dart';
import '../addresses/addresses.dart';
import '../contact/contact_us.dart';
import '../home/home_screen.dart';
import '../monthly_pkg/monthly_pkg.dart';
import '../notifications/notifications_screen.dart';
import '../requests/myRequests.dart';
import '../user/profile/edit_profile.dart';
import '../vehicles/my_vehicles.dart';
import '../wallet/wallet_payment.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return Drawer(
      backgroundColor:
          MyApp.themeMode(context) ? AppColor.darkScaffoldColor : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context, userDataProvider),
            buildMenuItems(context, userDataProvider),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(context, UserProvider userDataProvider) {
    return CustomContainer(
      backgroundColor: AppColor.lightBabyBlue,
      backgroundColorDark: AppColor.boldDark,
      borderColorDark: Colors.transparent,
      width: 272,
      // height: 175,
      padding: onlyEdgeInsets(top: 40, bottom: 16, start: 24, end: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: CachedNetworkImageProvider(userDataProvider
                    .profileData?.image ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0F6JSOHkKNsDAnJo3mBl98s0JXJ4dheYY-0jWCUjFJ0tiW6VyPfLJ_wQP&s=10"),
          ),
          verticalSpace(12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: userDataProvider.profileData?.name == ""
                        ? S.of(context).userName
                        : userDataProvider.profileData?.name ?? S.of(context).userName,
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size15,
                  ),
                  verticalSpace(6),
                  TextWidget(
                    text: userDataProvider.profileData?.phone ?? S.of(context).phoneNumber,
                    color: MyApp.themeMode(context)
                        ? const Color(0xff1E1E1E)
                        : const Color(0xff1E1E1E),
                    fontWeight: MyFontWeight.regular,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    MyApp.changeThemeMode(context);
                    navigateAndFinish(context, const HomeScreen());
                  },
                  icon: const Icon(Icons.dark_mode_outlined)),
              horizontalSpace(5),
              GestureDetector(
                onTap: () {
                  userDataProvider.changeLanguage(context);
                },
                child: SvgPicture.asset('assets/svg/translate.svg',
                    color: MyApp.themeMode(context)
                        ? AppColor.white
                        : AppColor.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context, UserProvider userDataProvider) {
    return Padding(
      padding: symmetricEdgeInsets(horizontal: 30, vertical: 42),
      child: CustomContainer(
        backgroundColor:
            MyApp.themeMode(context) ? AppColor.primaryDark : Colors.white,
        borderColor: AppColor.lightGrey,
        child: Column(
          children: [
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/profile.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).profile,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, const EditProfile());
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/requests.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).requests,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, ShowCaseWidget(
                  autoPlay: true,
                    autoPlayDelay: Duration(seconds: 2),
                    builder: Builder(builder: (context){return const MyRequests();})) );
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/wallet.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).wallet,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, const WalletPayment());
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/car.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).vehicles,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, ShowCaseWidget(
                    autoPlay: true,
                    autoPlayDelay: const Duration(seconds: 3),
                    builder: Builder(builder: (context){return const MyVehicles();})) );
                // navigateTo(context, const MyVehicles());
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/map.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).addresses,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, ShowCaseWidget(
                    autoPlay: true,
                    autoPlayDelay: const Duration(seconds: 3),
                    builder: Builder(builder: (context){return const MyAddresses();})) );
                /*navigateTo(
                  context,
                  const MyAddresses(),
                );*/
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/money.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).monthlyPkg,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(
                  context,
                  const MonthlyPkg(),
                );
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/about.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).aboutUs,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(
                  context,
                  const AboutUs(),
                );
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/messages.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).contactUs,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(
                  context,
                  const ContactUs(),
                );
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/messages.svg',
                  color:
                      MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).notifications,
                color:
                    MyApp.themeMode(context) ? AppColor.white : AppColor.grey,
                textSize: 18,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, const NotificationsScreen());
              },
            ),
            const Divider(
              height: 1,
              color: AppColor.lightGrey,
              thickness: 1,
            ),
            ListTile(
              leading: CustomSizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/svg/logout.svg',
                ),
              ),
              minLeadingWidth: 2.w,
              title: TextWidget(
                text: S.of(context).logOut,
                color: const Color(0xFFCC4A50),
                textSize: MyFontSize.size16,
                fontWeight: MyFontWeight.medium,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const LogOutDialog();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
