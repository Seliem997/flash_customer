import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/otherServicesModel.dart';
import '../../../providers/otherServices_provider.dart';
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
    this.onTap,
    required this.index,
    required this.service,
  });

  final String title, imageName;
  final String? serviceValue, serviceUnit;
  final bool seeMore, onlyValue;
  final GestureTapCallback? onTap;
  final int index;
  final OtherServicesData service;

  @override
  Widget build(BuildContext context) {
    final OtherServicesProvider otherServicesProvider =
        Provider.of<OtherServicesProvider>(context);

    return CustomContainer(
      width: 108,
      margin: onlyEdgeInsets(end: 11),
      radiusCircular: 5,
      backgroundColor: otherServicesProvider.selectedServiceIndex == index
          ? const Color(0xFFE1ECFF)
          : AppColor.borderGreyLight,
      borderColor: otherServicesProvider.selectedServiceIndex == index
          ? const Color(0xFF0285E0)
          : Colors.transparent,
      borderColorDark: otherServicesProvider.selectedServiceIndex == index
          ? const Color(0xFF0285E0)
          : const Color(0xFFE1ECFF),
      backgroundColorDark: otherServicesProvider.selectedServiceIndex == index
          ? AppColor.grey
          :Colors.transparent,
      padding: symmetricEdgeInsets(horizontal: 2, vertical: 10),
      onTap: onTap,
      child: Column(
        children: [
          verticalSpace(5),
          CustomSizedBox(
            width: 60,
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
                  text: S.of(context).seeMore,
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
                            text: S.of(context).per,
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
                    ),
          verticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomContainer(
                onTap: () {
                  otherServicesProvider.selectedService(index: index);
                  otherServicesProvider.decreaseQuantityService();
                },
                width: 20,
                height: 20,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.zero,
                backgroundColor: Colors.transparent,
                image: const DecorationImage(
                    image: AssetImage('assets/images/minus.png'),
                    fit: BoxFit.fitHeight),
              ),
              horizontalSpace(15),
              TextWidget(
                text: '${service.quantity}',
                fontWeight: MyFontWeight.bold,
                textSize: MyFontSize.size12,
              ),
              horizontalSpace(15),
              CustomContainer(
                onTap: () {
                  otherServicesProvider.increaseQuantityService(selectedServiceIndex: index);
                  otherServicesProvider.selectedService(index: index);
                },
                width: 20,
                height: 20,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.zero,
                backgroundColor: Colors.transparent,
                image: const DecorationImage(
                    image: AssetImage('assets/images/plus.png'),
                    fit: BoxFit.fitHeight,
                ),
              ),
            ],
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
