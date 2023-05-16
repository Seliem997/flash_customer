import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';

import '../../providers/requestServices_provider.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class SummaryRequestDetails extends StatelessWidget {
  const SummaryRequestDetails({
    super.key,
    required this.requestServicesProvider,
    this.cameFromOtherServices= false,
  });

  final bool cameFromOtherServices;
  final RequestServicesProvider requestServicesProvider;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 345,
      radiusCircular: 4,
      borderColor: AppColor.primary,
      backgroundColor: const Color(0xFFF1F6FE),
      child: Padding(
        padding: symmetricEdgeInsets(
            vertical: 24, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Location',
              textSize: MyFontSize.size15,
              fontWeight: MyFontWeight.semiBold,
            ),
            verticalSpace(10),
            TextWidget(
              text: '${requestServicesProvider.detailsRequestData!.city!.name}',
              textSize: MyFontSize.size12,
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
                    text: 'Vehicle',
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  TextWidget(
                    text: '${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].manufacturerName!} - ${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].vehicleModelName!} - ${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].vehicleModelName!}',
                    // text: '${requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].manufacturerName!} - ${requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].vehicleModelName!} - ${requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].vehicleModelName!}',
                    // text: 'Small Car - Blue Yaris ACWS 2190',
                    textSize: MyFontSize.size12,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.subTextGrey,
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
            TextWidget(
              text: 'Date & Time',
              textSize: MyFontSize.size15,
              fontWeight: MyFontWeight.semiBold,
            ),
            verticalSpace(10),
            TextWidget(
              text:
              "${requestServicesProvider.detailsRequestData!.date!} - ${requestServicesProvider.detailsRequestData!.time!}",
              textSize: MyFontSize.size12,
              fontWeight: MyFontWeight.regular,
              color: AppColor.subTextGrey,
            ),
            verticalSpace(20),
            TextWidget(
              text: 'Services',
              textSize: MyFontSize.size15,
              fontWeight: MyFontWeight.semiBold,
            ),
            verticalSpace(10),
            CustomSizedBox(
              // height: 25,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: requestServicesProvider
                    .detailsRequestData!
                    .services!
                    .length,
                itemBuilder: (context, index) {
                  if (requestServicesProvider
                      .detailsRequestData!
                      .services![index]
                      .type ==
                      'basic' || requestServicesProvider
                      .detailsRequestData!
                      .services![index]
                      .type == "other" ) {
                    return TextWidget(
                      text: requestServicesProvider
                          .detailsRequestData!
                          .services![index]
                          .title!,
                      textSize: MyFontSize.size12,
                      fontWeight: MyFontWeight.regular,
                      color: AppColor.subTextGrey,
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
                    text: 'Extra Services',
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  verticalSpace(10),
                  CustomSizedBox(
                    // height: 25,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: requestServicesProvider
                          .detailsRequestData!
                          .services!
                          .length,
                      itemBuilder: (context, index) {
                        if (requestServicesProvider
                            .detailsRequestData!
                            .services![index]
                            .type ==
                            'extra') {
                          return TextWidget(
                            text: requestServicesProvider
                                .detailsRequestData!
                                .services![index]
                                .title!,
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.regular,
                            color: AppColor.subTextGrey,
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
            Row(
              children: [
                TextWidget(
                  text: 'Service Duration',
                  textSize: MyFontSize.size15,
                  fontWeight: MyFontWeight.semiBold,
                ),
                horizontalSpace(10),
                TextWidget(
                  text:
                  "${requestServicesProvider.detailsRequestData!.totalDuration}",
                  textSize: MyFontSize.size15,
                  fontWeight: MyFontWeight.medium,
                  color: const Color(0xFF686868),
                ),
                verticalSpace(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
