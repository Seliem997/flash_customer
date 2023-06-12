import 'package:flash_customer/ui/date_time/select_date.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/font_styles.dart';
import '../../models/packagesModel.dart';
import '../../providers/package_provider.dart';
import '../../utils/number_formats.dart';
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
    packageProvider.packageWashingQuantities = packagesData.washingQuantity;
    return Scaffold(
      appBar: CustomAppBar(title: 'Date & Time'),
      body: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: ListView.separated(
            itemCount: packagesData.washingQuantity!,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '${index+1}${ordinal(index+1)} wash',
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size15,
                  ),
                  verticalSpace(12),
                  packageProvider.washesTime[index] == null
                      ? CustomContainer(
                    clipBehavior: Clip.hardEdge,
                    width: double.infinity,
                    height: 75,
                    onTap: (){
                      navigateTo(context, SelectDate(cameFromPackage: true, index: index),);

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
                              text: 'No date & time',
                              fontWeight: MyFontWeight.medium,
                              textSize: MyFontSize.size12,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                      : Column(
                        children: [
                          CustomContainer(
                    clipBehavior: Clip.hardEdge,
                    width: double.infinity,
                    height: 75,
                    backgroundColor: AppColor.selectedColor,
                    onTap: (){
                          navigateTo(context, SelectDate(cameFromPackage: true,index: index,),);
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
                              padding:
                              symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset('assets/svg/calendar.svg'),
                                          horizontalSpace(10),
                                          TextWidget(
                                            text: packageProvider.washesDate[index],
                                            textSize: MyFontSize.size10,
                                            fontWeight: MyFontWeight.medium,
                                            color: const Color(0xff282828),
                                          ),
                                        ],
                                      ),
                                      verticalSpace(10),
                                      Row(
                                        children: [
                                          SvgPicture.asset('assets/svg/clock (1).svg'),
                                          horizontalSpace(10),
                                          TextWidget(
                                            text: packageProvider.washesTime[index],
                                            textSize: MyFontSize.size10,
                                            fontWeight: MyFontWeight.medium,
                                            color: const Color(0xff282828),
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
                          DefaultButton(
                            text:  'Pay',
                            onPressed: packageProvider.packageWashingQuantities == packageProvider.washesDate.length
                                ? (){
                              print("in Pay");

                              packageProvider.saveSlotsPackageRequest(requestId: packageProvider.detailsRequestData!.id!);
                            }:(){
                              print("in Pay Nothing");

                            },
                            fontWeight: MyFontWeight.bold,
                            fontSize: 21,
                            height: 48,
                            width: 345,
                          ),

                        ],
                      ),
                ],
              );
            },
            separatorBuilder: (context, index) => verticalSpace(24),
          ),
      ),
    );
  }
}

/*
               CustomContainer(
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: 75,
                onTap: (){
                  navigateTo(context, const SelectDate());
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
                          text: 'No date & time',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size12,
                        ),
                      ),
                    )
                  ],
                ),
              )
* */