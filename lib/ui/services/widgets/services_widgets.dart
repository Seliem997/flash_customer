import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/servicesModel.dart';
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
    this.onTap,
    required this.index,
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
      // height: 59,
      width: 313,
      onTap: onTap,
      backgroundColor: servicesProvider.selectedBasicIndex == index
          ? const Color(0xFFE1ECFF)
          : const Color(0xFFD1D1D1),
      backgroundColorDark: servicesProvider.selectedBasicIndex == index
          ? const Color(0xFFE1ECFF)
          : Colors.transparent,
      radiusCircular: 4,
      child: Row(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: infoOnPressed != null ? IconButton(
              icon: const Icon(Icons.info, size: 20, color: AppColor.primary),
              onPressed: infoOnPressed,
            ) : const SizedBox(width: 45),
          ),
          CustomSizedBox(
            height: 35,
            width: 35,
            child: Image.network(imageName),
          ),
          horizontalSpace(12),
          Expanded(
            child: TextWidget(
              text: title,
              maxLines: 2,
              textSize: MyFontSize.size10,
              fontWeight: MyFontWeight.semiBold,
              colorDark: servicesProvider.selectedBasicIndex == index ? Colors.black : Colors.white,
            ),
          ),
          // const Spacer(),
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
                    height: 17,
                    width: 17,
                    borderColor: AppColor.subTextGrey,
                  ),
          )
        ],
      ),
    );
  }
}

class ExtraServicesWidget extends StatelessWidget {
  const ExtraServicesWidget(
      {super.key, this.infoOnPressed, this.onTap, required this.extraService});

  final VoidCallback? infoOnPressed;
  final GestureTapCallback? onTap;
  final ServiceData extraService;

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);
    return CustomContainer(
      height: 59,
      backgroundColor: extraService.isSelected || extraService.quantity > 0
          ? const Color(0xFFE1ECFF)
          : const Color(0xFFD1D1D1),
      backgroundColorDark: extraService.isSelected || extraService.quantity > 0
          ? const Color(0xFFE1ECFF) : null,
      radiusCircular: 4,
      child: Row(
        children: [
          Row(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: infoOnPressed != null ? IconButton(
                  icon: const Icon(Icons.info, size: 20, color: AppColor.primary),
                  onPressed: infoOnPressed,
                ) : SizedBox(width: 45,),
              ),
              CustomSizedBox(
                height: 30,
                width: 30,
                child: Image.network(extraService.image!),
              ),
              horizontalSpace(10),
              CustomContainer(
                width: 125,
                borderColorDark: Colors.transparent,
                child: TextWidget(
                  text: extraService.title!,
                  textSize: MyFontSize.size10,
                  fontWeight: MyFontWeight.semiBold,
                  maxLines: 2,
                  colorDark: extraService.isSelected || extraService.quantity > 0
                      ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: onlyEdgeInsets(end: 10),
              child: extraService.countable!
                  ? Row(
                      children: [
                        CustomContainer(
                          onTap: () {
                            if (extraService.quantity > 0) {
                              extraService.quantity--;
                              requestServicesProvider.notifyListeners();
                              requestServicesProvider.calculateTotal();
                            }
                          },
                          width: 28,
                          height: 28,
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.zero,
                          backgroundColor: Colors.transparent,
                          image: const DecorationImage(
                              image: AssetImage('assets/images/minus.png'),
                              fit: BoxFit.fitHeight),
                        ),
                        horizontalSpace(9),
                        TextWidget(
                          text: extraService.quantity.toString(),
                          fontWeight: MyFontWeight.bold,
                          textSize: MyFontSize.size14,
                          colorDark: extraService.quantity > 0 ? Colors.black : Colors.white,
                        ),
                        horizontalSpace(9),
                        CustomContainer(
                          onTap: () {
                            extraService.quantity++;
                            requestServicesProvider.notifyListeners();
                            requestServicesProvider.calculateTotal();
                          },
                          width: 28,
                          height: 28,
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.zero,
                          backgroundColor: Colors.transparent,
                          image: const DecorationImage(
                              image: AssetImage('assets/images/plus.png'),
                              fit: BoxFit.fitHeight),
                        ),
                      ],
                    )
                  : CustomContainer(
                      borderColorDark: Colors.transparent,
                      onTap: () {
                        extraService.isSelected = !extraService.isSelected;
                        extraService.isSelected ? extraService.quantity = 1 : extraService.quantity = 0;
                        requestServicesProvider.notifyListeners();
                        requestServicesProvider.calculateTotal();
                      },
                      radiusCircular: 5,
                      backgroundColor: extraService.isSelected
                          ? AppColor.primary
                          : Colors.transparent,
                      height: 17,
                      width: 17,
                      borderColor: extraService.isSelected
                          ? AppColor.primary
                          : AppColor.subTextGrey,
                      child: extraService.isSelected
                  ? Image.asset('assets/images/checkIcon.png')
                          : Container(),
                    ),
            ),
          )
        ],
      ),
      onTap: (){
        extraService.countable! ? null : extraService.isSelected = !extraService.isSelected;
        extraService.isSelected ? extraService.quantity = 1 : extraService.quantity = 0;
        requestServicesProvider.notifyListeners();
        requestServicesProvider.calculateTotal();
      },
    );
  }
}
