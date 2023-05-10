import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/requestServices_provider.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key, required this.requestId}) : super(key: key);

  final int requestId;
  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context, listen: false);
    await requestServicesProvider
        .getRequestDetails(requestId: widget.requestId)
        .then((value) => requestServicesProvider.setLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context,);
    return Scaffold(
      appBar: CustomAppBar(title: 'Request Details'),
      body: SingleChildScrollView(
        child: requestServicesProvider.isLoading
            ? const DataLoader()
            : Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            children: [
              CustomContainer(
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
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text: '${requestServicesProvider.detailsRequestData!.city!.name}',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
                      TextWidget(
                        text: 'Vehicle',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                       text: '${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].manufacturerName!} - ${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].vehicleModelName!} - ${requestServicesProvider.detailsRequestData!.customer!.vehicle![0].vehicleModelName!}',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
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
                          itemCount: requestServicesProvider.detailsRequestData!
                              .services!
                              .length,
                          itemBuilder: (context, index) {
                            if (requestServicesProvider.detailsRequestData!
                                .services![index]
                                .type ==
                                'basic') {
                              return TextWidget(
                                text: requestServicesProvider.detailsRequestData!
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
                      TextWidget(
                        text: 'Extra Services',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      CustomSizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: requestServicesProvider.detailsRequestData!
                              .services!
                              .length,
                          itemBuilder: (context, index) {
                            if (requestServicesProvider.detailsRequestData!
                                .services![index]
                                .type ==
                                'extra') {
                              return TextWidget(
                                text: requestServicesProvider.detailsRequestData!
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
                      Row(
                        children: [
                          TextWidget(
                            text: 'Service Duration',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          horizontalSpace(10),
                          TextWidget(
                            text: '${requestServicesProvider.detailsRequestData!.totalDuration} Min',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
