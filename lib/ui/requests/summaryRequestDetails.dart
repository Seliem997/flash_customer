import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class SummaryRequestDetails extends StatelessWidget {
  const SummaryRequestDetails({
    super.key,
    required this.requestServicesProvider,
    this.cameFromOtherServices = false,
    this.cameFromMonthlyPackage = false,
  });

  final bool cameFromOtherServices;
  final bool cameFromMonthlyPackage;
  final RequestServicesProvider requestServicesProvider;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 345,
      radiusCircular: 4,
      borderColor: AppColor.primary,
      backgroundColor: const Color(0xFFF1F6FE),
      child: Padding(
        padding: symmetricEdgeInsets(vertical: 24, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: S.of(context).location,
              textSize: MyFontSize.size18,
              fontWeight: MyFontWeight.semiBold,
            ),
            verticalSpace(10),
            TextWidget(
              text: '${requestServicesProvider.detailsRequestData!.city!.name}',
              textSize: MyFontSize.size15,
              fontWeight: MyFontWeight.regular,
              color: AppColor.subTextGrey,
            ),
            verticalSpace(20),
            Visibility(
              visible: !cameFromOtherServices,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: S.of(context).vehicle,
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  TextWidget(
                    text:
                        '${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].manufacturerName!} - ${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].vehicleModelName!}',
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.subTextGrey,
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
            !cameFromMonthlyPackage
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: S.of(context).dateTime,
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text:
                            "${requestServicesProvider.detailsRequestData!.slotsDate!} - ${requestServicesProvider.detailsRequestData!.time}",
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                    ],
                  )
                : Container(),
            Visibility(
              visible: !cameFromMonthlyPackage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20),
                  TextWidget(
                    text: S.of(context).basicServices,
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  CustomSizedBox(
                    // height: 25,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: requestServicesProvider
                          .detailsRequestData!.services!.length,
                      itemBuilder: (context, index) {
                        if (requestServicesProvider.detailsRequestData!
                                    .services![index].type ==
                                'basic' ||
                            requestServicesProvider.detailsRequestData!
                                    .services![index].type ==
                                "other") {
                          return requestServicesProvider.detailsRequestData!
                              .services![index].type ==
                              'basic' ? TextWidget(
                            text: requestServicesProvider
                                .detailsRequestData!.services![index].title!,
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.regular,
                            color: AppColor.subTextGrey,

                          ) : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextWidget(
                              text: '${requestServicesProvider
                                  .detailsRequestData!.services![index].requestServiceCount} ${S.of(context).from} ${requestServicesProvider
                                  .detailsRequestData!.services![index].title!}',
                              textSize: MyFontSize.size15,
                              fontWeight: MyFontWeight.regular,
                              color: AppColor.subTextGrey,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  verticalSpace(20),
                  Visibility(
                    visible: !cameFromOtherServices,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: S.of(context).extraServices,
                          textSize: MyFontSize.size18,
                          fontWeight: MyFontWeight.semiBold,
                        ),
                        verticalSpace(10),
                        CustomSizedBox(
                          // height: 25,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: requestServicesProvider
                                .detailsRequestData!.services!.length,
                            itemBuilder: (context, index) {
                              if (requestServicesProvider.detailsRequestData!
                                      .services![index].type ==
                                  'extra') {
                                return TextWidget(
                                  text:  '${requestServicesProvider
                                      .detailsRequestData!
                                      .services![index]
                                      .requestServiceCount} ${S.of(context).from} ${requestServicesProvider
                                      .detailsRequestData!
                                      .services![index]
                                      .title!}',
                                  textSize: MyFontSize.size15,
                                  fontWeight: MyFontWeight.regular,
                                  height: 1.4,
                                  color: AppColor.subTextGrey,
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        verticalSpace(20),
                      ],
                    ),
                  ),
                  TextWidget(
                    text: S.of(context).serviceDuration,
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      TextWidget(
                        text:
                            "${requestServicesProvider.detailsRequestData!.totalDuration}",
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.medium,
                        color: const Color(0xFF686868),
                      ),
                      horizontalSpace(5),
                      TextWidget(
                        text: S.of(context).minutes,
                        textSize: MyFontSize.size14,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: cameFromMonthlyPackage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20),
                  TextWidget(
                    text: S.of(context).packageName,
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  CustomSizedBox(
                    // height: 25,
                    child: TextWidget(
                      text: Intl.getCurrentLocale() == 'ar'
                          ? '${requestServicesProvider.detailsRequestData!.packageDetails?.nameAr}'
                          : '${requestServicesProvider.detailsRequestData!.packageDetails?.nameEn}',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.regular,
                      color: AppColor.subTextGrey,
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      TextWidget(
                        text: S.of(context).washingQuantity,
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      horizontalSpace(10),
                      TextWidget(
                        text:
                            '${requestServicesProvider.detailsRequestData!.packageDetails?.washingQuantity}',
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.medium,
                        color: const Color(0xFF686868),
                      ),
                      verticalSpace(20),
                    ],
                  ),
                  verticalSpace(20),
                  TextWidget(
                    text: S.of(context).serviceDuration,
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      TextWidget(
                        text:
                            "${requestServicesProvider.detailsRequestData!.packageDetails?.duration}",
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.medium,
                        color: const Color(0xFF686868),
                      ),
                      horizontalSpace(5),
                      TextWidget(
                        text: S.of(context).minutes,
                        textSize: MyFontSize.size14,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
