import 'package:flash_customer/ui/date_time/select_date.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/font_styles.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../../models/packagesModel.dart';
import '../../providers/package_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/number_formats.dart';
import '../../utils/snack_bars.dart';
import '../requests/request_details_payment.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class WashesDate extends StatelessWidget {
  const WashesDate({Key? key, required this.packagesData}) : super(key: key);
  final PackagesData packagesData;
  @override
  Widget build(BuildContext context) {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context);
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context);
    packageProvider.packageWashingQuantities = packagesData.washingQuantity;
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).dateTime),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: packagesData.washingQuantity!,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: '${index + 1}${ordinal(index + 1)} ${S.of(context).washh}',
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size15,
                      ),
                      verticalSpace(12),
                      packageProvider.washesTime[index] == null
                          ? CustomContainer(
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              height: 75,
                              onTap: () {
                                navigateTo(
                                  context,
                                  SelectDate(
                                      cameFromPackage: true, index: index),
                                );
                              },
                              backgroundColor: AppColor.borderGreyLight,
                              child: Row(
                                children: [
                                  const CustomContainer(
                                    width: 8,
                                    height: double.infinity,
                                    radiusCircular: 0,
                                    backgroundColor: Color(0xFF898A8D),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: TextWidget(
                                        text: S.of(context).noDateTime,
                                        fontWeight: MyFontWeight.medium,
                                        textSize: MyFontSize.size12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : CustomContainer(
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              height: 75,
                              backgroundColor: AppColor.selectedColor,
                              onTap: () {
                                navigateTo(
                                  context,
                                  SelectDate(
                                    cameFromPackage: true,
                                    index: index,
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  const CustomContainer(
                                    width: 8,
                                    height: double.infinity,
                                    radiusCircular: 0,
                                    backgroundColor: AppColor.primary,
                                  ),
                                  Padding(
                                    padding: symmetricEdgeInsets(
                                        horizontal: 12.5, vertical: 13.5),
                                    child: Row(
                                      children: [
                                        CustomContainer(
                                          borderColor: const Color(0xFF0096FF),
                                          height: 45,
                                          width: 45,
                                          backgroundColor: Colors.transparent,
                                          radiusCircular: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/images/car_wash.png',
                                            ),
                                          ),
                                        ),
                                        horizontalSpace(24),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/svg/calendar.svg', color: MyApp.themeMode(context) ? Colors.white : const Color(0xff616161),),
                                                horizontalSpace(10),
                                                TextWidget(
                                                  text:
                                                      '${packageProvider.washesDate[index]}',
                                                  textSize: MyFontSize.size10,
                                                  fontWeight:
                                                      MyFontWeight.medium,
                                                  color:
                                                      const Color(0xff282828),
                                                ),
                                              ],
                                            ),
                                            verticalSpace(10),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/svg/clock (1).svg', color: MyApp.themeMode(context) ? Colors.white : const Color(0xff616161),),
                                                horizontalSpace(10),
                                                TextWidget(
                                                  text: packageProvider
                                                      .washesTime[index],
                                                  textSize: MyFontSize.size10,
                                                  fontWeight:
                                                      MyFontWeight.medium,
                                                  color:
                                                      const Color(0xff282828),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => verticalSpace(24),
              ),
            ),
            verticalSpace(5),
            DefaultButton(
              text: S.of(context).pay,
              onPressed: packageProvider.packageWashingQuantities ==
                      packageProvider.washesDate.length
                  ? () {
                      AppLoader.showLoader(context);
                      packageProvider
                          .saveSlotsPackageRequest(
                              requestId:
                                  packageProvider.detailsRequestData!.id!)
                          .then((value) {
                            // AppLoader.stopLoader();
                            if (value.status == Status.success) {
                              requestServicesProvider
                                  .updateRequestSlots(
                                requestId: packageProvider.detailsRequestData!.id!,
                                payBy: "cash",
                              )
                                  .then((value) {
                                if (value.status == Status.success) {
                                  AppLoader.stopLoader();
                                  navigateTo(
                                      context,
                                      RequestDetails(
                                        requestId: packageProvider.detailsRequestData!.id!,
                                        cameFromMonthlyPackage: true,
                                      ));
                                } else {
                                  AppLoader.stopLoader();
                                  CustomSnackBars.failureSnackBar(
                                      context, '${value.message}');
                                }
                              });
                            } else {
                              AppLoader.stopLoader();
                              CustomSnackBars.failureSnackBar(
                                  context, '${value.message}');
                            }
                          });
                    }
                  : () {
                      CustomSnackBars.failureSnackBar(
                          context, S.of(context).chooseAllWashesFirst);
                    },
              fontWeight: MyFontWeight.bold,
              fontSize: 21,
              height: 48,
              width: 345,
            ),
          ],
        ),
      ),
    );
  }
}

