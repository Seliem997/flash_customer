import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_customer/ui/sidebar_drawer/widgets/logout_dialog.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/user_provider.dart';
import '../../utils/styles/colors.dart';
import '../../utils/font_styles.dart';
import '../about/about.dart';
import '../addresses/addresses.dart';
import '../contact/contact_us.dart';
import '../monthly_pkg/monthly_pkg.dart';
import '../user/profile/edit_profile.dart';
import '../user/register/register.dart';
import '../vehicles/my_vehicles.dart';
import '../wallet/wallet.dart';
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context,userDataProvider),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(context,UserProvider userDataProvider) {
    return CustomContainer(
      backgroundColor: userDataProvider.isDark ? AppColor.boldDark : AppColor.lightBabyBlue,
      width: 272,
      height: 175,
      padding: onlyEdgeInsets(top: 32, bottom: 16, start: 24, end: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: CachedNetworkImageProvider(userDataProvider
                    .userImage ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0F6JSOHkKNsDAnJo3mBl98s0JXJ4dheYY-0jWCUjFJ0tiW6VyPfLJ_wQP&s=10"),
          ),
          verticalSpace(12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: userDataProvider.userName == "" ? "User Name" : userDataProvider.userName ?? "User Name",
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size15,
                  ),
                  verticalSpace(6),
                  TextWidget(
                    text: userDataProvider.phone ?? 'phone Number',
                    color: !userDataProvider.isDark ? const Color(0xff1E1E1E) : const Color(0xffDBDBDB),
                    fontWeight: MyFontWeight.regular,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextWidget(
                          text: 'Want to Switch Dark Mode?',
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: symmetricEdgeInsets(vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              DefaultButton(
                                width: 130,
                                height: 30,
                                text: 'Cancel',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                backgroundColor: const Color(0xFF6BB85F),
                              ),
                              DefaultButton(
                                width: 130,
                                height: 30,
                                text: 'Switch',
                                onPressed: () {
                                  Navigator.pop(context);
                                  userDataProvider.changeAppMode();
                                },
                                backgroundColor: const Color(0xFFB85F66),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }, icon: Icon(Icons.dark_mode_outlined)),
              horizontalSpace(5),
              SvgPicture.asset('assets/svg/translate.svg',color: userDataProvider.isDark ? AppColor.white : AppColor.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Padding(
      padding: symmetricEdgeInsets(horizontal: 30, vertical: 42),
      child: Column(
        children: [
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/profile.svg',
                color: AppColor.grey,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Profile',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
              navigateTo(context, const EditProfile());
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/requests.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Requests',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              // Navigator.pop(context);
              // navigateTo(context, const EditProfile());
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/wallet.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Wallet',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
              navigateTo(context, const WalletScreen());
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/car.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Vehicles',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
              navigateTo(context, const MyVehicles());
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/map.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Addresses',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
              navigateTo(
                context,
                const MyAddresses(),
              );
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/money.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Monthly pkg',
              color: AppColor.grey,
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
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/about.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'About us',
              color: AppColor.grey,
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
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/messages.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Contact us',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
              navigateTo(context, const ContactUs(),);
            },
          ),
          verticalSpace(50),
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
              text: "Log out",
              color: Color(0xFFCC4A50),
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
    );
  }
}
