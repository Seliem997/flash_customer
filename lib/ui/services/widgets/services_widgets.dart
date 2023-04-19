import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/requestServices_provider.dart';
import '../../../utils/font_styles.dart';
import '../../../utils/styles/colors.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class BasicServicesWidget extends StatelessWidget {
  const BasicServicesWidget({
    super.key,
    this.infoOnPressed,
    required this.title,
    required this.imageName,
    this.onTap, required this.index,
  });

  final VoidCallback? infoOnPressed;
  final String title, imageName;
  final int index;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider servicesProvider =
    Provider.of<RequestServicesProvider>(context);
    return CustomContainer(
      height: 59,
      width: 313,
      onTap: onTap,
      backgroundColor:
         servicesProvider.selectedBasicIndex == index ? const Color(0xFFE1ECFF) : const Color(0xFFD1D1D1),
      radiusCircular: 4,
      child: Row(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: IconButton(
              icon: const Icon(Icons.info, size: 20, color: AppColor.primary),
              onPressed: infoOnPressed,
            ),
          ),
          CustomSizedBox(
            height: 35,
            width: 35,
            child: Image.network(imageName),
          ),
          horizontalSpace(12),
          TextWidget(
            text: title,
            textSize: MyFontSize.size12,
            fontWeight: MyFontWeight.semiBold,
          ),
          const Spacer(),
          Padding(
            padding: onlyEdgeInsets(
              end: 20,
              bottom: 20,
              top: 20,
            ),
            child: servicesProvider.selectedBasicIndex == index
                ? Image.asset('assets/images/checkIcon.png')
                : const CustomContainer(
                    radiusCircular: 5,
                    backgroundColor: Colors.transparent,
                    height: 19,
                    width: 20,
                    borderColor: AppColor.subTextGrey,
                  ),
          )
        ],
      ),
    );
  }
}

class ExtraServicesWidget extends StatelessWidget {
  const ExtraServicesWidget({
    super.key,
    this.infoOnPressed,
    required this.title,
    required this.imageName,
    this.onCheck = false,
    this.onTap,
    this.isCounted = false,
  });

  final VoidCallback? infoOnPressed;
  final String title, imageName;
  final bool onCheck, isCounted;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 59,
      width: 313,
      backgroundColor: onCheck ? const Color(0xFFE1ECFF) : const Color(0xFFD1D1D1),
      radiusCircular: 4,
      child: Row(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: IconButton(
              icon: const Icon(Icons.info, size: 20, color: AppColor.primary),
              onPressed: () {},
            ),
          ),
          CustomSizedBox(
              height: 35,
              width: 35,
              child: Image.network(imageName),
          ),
          horizontalSpace(12),
          TextWidget(
            text: title,
            textSize: MyFontSize.size12,
            fontWeight: MyFontWeight.semiBold,
          ),
          const Spacer(),
          Padding(
            padding: onlyEdgeInsets(
              end: 20,
              bottom: 20,
              top: 20,
            ),
            child: isCounted
                ? Row(
                    children: [
                      CustomSizedBox(
                        width: 18,
                        height: 23,
                        child: Image.asset('assets/images/minus.png'),
                      ),
                      horizontalSpace(9),
                      TextWidget(
                        text: '1',
                        fontWeight: MyFontWeight.bold,
                        textSize: MyFontSize.size12,
                      ),
                      horizontalSpace(9),
                      CustomSizedBox(
                        width: 18,
                        height: 23,
                        child: Image.asset('assets/images/plus.png'),
                      ),
                    ],
                  )
                : Padding(
              padding: onlyEdgeInsets(end: 20,),
                  child: const CustomContainer(
              radiusCircular: 5,
              backgroundColor: Colors.transparent,
              height: 19,
              width: 20,
              borderColor: AppColor.subTextGrey,
            ),
                ),
          )
        ],
      ),
    );
  }
}
