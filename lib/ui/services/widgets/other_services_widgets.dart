import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class OtherServicesItem extends StatelessWidget {
  const OtherServicesItem({
    super.key,
    required this.title,
    required this.imageName,
    this.serviceValue,
    this.serviceUnit,
    this.seeMore = false,
    this.onlyValue = false,
    this.onTap, this.infoOnPressed,
  });

  final String title, imageName;
  final String? serviceValue, serviceUnit;
  final bool seeMore, onlyValue;
  final GestureTapCallback? onTap;
  final VoidCallback? infoOnPressed;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 108,
      height: 130,
      margin: onlyEdgeInsets(end: 11),
      radiusCircular: 5,
      backgroundColor: AppColor.borderGreyLight,
      padding: symmetricEdgeInsets(horizontal: 2, vertical: 2),
      onTap: onTap,
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              icon: const Icon(Icons.info, size: 20, color: AppColor.primary),
              onPressed: infoOnPressed,
            ),
            // child: Icon(Icons.info, size: 20, color: AppColor.primary),
          ),
          CustomSizedBox(
            width: 56,
            height: 56,
            child: Image.network(imageName),
          ),
          verticalSpace(11),
          TextWidget(
            text: title,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            textSize: MyFontSize.size9,
          ),
          verticalSpace(8),
          seeMore
              ? TextWidget(
                  text: 'See more',
                  fontWeight: MyFontWeight.medium,
                  textSize: MyFontSize.size8,
                  color: const Color(0xFF636363),
                )
              : onlyValue
                  ? TextWidget(
                      text: serviceValue!,
                      fontWeight: MyFontWeight.medium,
                      textSize: MyFontSize.size10,
                      color: AppColor.attributeColor,
                    )
                  : FittedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: serviceValue!,
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: AppColor.attributeColor,
                          ),
                          horizontalSpace(5),
                          TextWidget(
                            text: 'per',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size8,
                            color: const Color(0xFF575757),
                          ),
                          horizontalSpace(5),
                          TextWidget(
                            text: serviceUnit!,
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: AppColor.attributeColor,
                          ),
                        ],
                      ),
                  )
        ],
      ),
    );
  }
}

class WaxingServicesItem extends StatelessWidget {
  const WaxingServicesItem({
    super.key,
    required this.title,
    required this.imageName,
    required this.serviceValue,
  });
  final String title, imageName, serviceValue;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 64,
      width: double.infinity,
      backgroundColor: AppColor.borderGreyLight,
      radiusCircular: 5,
      margin: onlyEdgeInsets(bottom: 12),
      padding: symmetricEdgeInsets(horizontal: 15, vertical: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomSizedBox(
                    width: 90,
                    child: TextWidget(
                      text: title,
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size12,
                    ),
                  ),
                  horizontalSpace(11),
                  CustomSizedBox(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset('assets/svg/Info.svg'),
                  ),
                ],
              ),
              verticalSpace(8),
              TextWidget(
                text: serviceValue,
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size10,
                color: AppColor.attributeColor,
              ),
            ],
          ),
          const Spacer(),
          CustomSizedBox(
            width: 44,
            height: 44,
            child: Image.asset(imageName),
          ),
        ],
      ),
    );
  }
}
