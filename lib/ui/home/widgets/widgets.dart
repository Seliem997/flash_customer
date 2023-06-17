import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../utils/styles/colors.dart';
import '../../addresses/new_address.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/expanded_container.dart';
import '../../widgets/text_widget.dart';

class SavedLocationExpanded extends StatefulWidget {
  const SavedLocationExpanded({Key? key}) : super(key: key);

  @override
  State<SavedLocationExpanded> createState() => _SavedLocationExpandedState();
}

class _SavedLocationExpandedState extends State<SavedLocationExpanded> {
  bool expandLocationFlag = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: ExpandableContainer(
            expanded: expandLocationFlag,
            expandedHeight: 27.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: Column(
                children: [
                  DefaultButtonWithIcon(
                    width: 187,
                    height: 34,
                    padding: symmetricEdgeInsets(horizontal: 28),
                    borderRadius: BorderRadius.circular(8),
                    backgroundButton: AppColor.white,
                    icon: CustomSizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/images/home_light.png')),
                    onPressed: () {},
                    labelText: S.of(context).home,
                    textColor: AppColor.black,
                  ),
                  verticalSpace(8),
                  DefaultButtonWithIcon(
                    width: 187,
                    height: 34,
                    padding: symmetricEdgeInsets(horizontal: 28),
                    borderRadius: BorderRadius.circular(8),
                    backgroundButton: AppColor.white,
                    icon: SvgPicture.asset(
                      'assets/svg/work.svg',
                    ),
                    onPressed: () {},
                    labelText: S.of(context).work,
                    textColor: AppColor.black,
                  ),
                  verticalSpace(8),
                  DefaultButtonWithIcon(
                    width: 187,
                    height: 34,
                    padding: symmetricEdgeInsets(horizontal: 28),
                    borderRadius: BorderRadius.circular(8),
                    backgroundButton: AppColor.white,
                    icon: SvgPicture.asset(
                      'assets/svg/school.svg',
                    ),
                    onPressed: () {},
                    labelText: S.of(context).school,
                    textColor: AppColor.black,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                          context,
                          const NewAddress(
                            cameFromHomeScreen: true,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.primary),
                      child: const Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomContainer(
          onTap: () {
            setState(() {
              expandLocationFlag = !expandLocationFlag;
            });
          },
          width: 219,
          height: 38,
          padding: symmetricEdgeInsets(horizontal: 30),
          backgroundColor: AppColor.primary,
          child: Row(
            children: <Widget>[
              TextWidget(
                text: S.of(context).savedLocation,
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
                color: AppColor.white,
              ),
              const Spacer(),
              Container(
                height: 18.0,
                width: 18.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 1, color: AppColor.white),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    expandLocationFlag
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
