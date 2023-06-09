import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/enum/statuses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';
import '../../providers/myVehicles_provider.dart';
import '../../providers/package_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../../utils/font_styles.dart';
import '../date_time/washes_date.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class MonthlyPlans extends StatefulWidget {
  const MonthlyPlans({Key? key, this.myVehicleIndex}) : super(key: key);

  final int? myVehicleIndex;
  @override
  State<MonthlyPlans> createState() => _MonthlyPlansState();
}

class _MonthlyPlansState extends State<MonthlyPlans> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context, listen: false);
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context, listen: false);
    final HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    await requestServicesProvider.getCityId(
      context,
      lat: homeProvider.currentPosition!.latitude,
      long: homeProvider.currentPosition!.longitude,
    );
    await packageProvider.getPackages(cityId: requestServicesProvider.cityIdData!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context);
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);
    final MyVehiclesProvider myVehiclesProvider =
    Provider.of<MyVehiclesProvider>(context);

    return Scaffold(
        appBar: CustomAppBar(title: 'Monthly pkg'),
        body: packageProvider.packagesDataList.isEmpty
            ? const DataLoader()
            : Padding(
                padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Select Package',
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size16,
                    ),
                    verticalSpace(23),
                    Expanded(
                      child: ListView.separated(
                        itemCount: packageProvider.packagesDataList.length,
                        itemBuilder: (context, index) {
                          return PackageCard(
                              packageProvider: packageProvider,
                              index: index,
                              isSelected: packageProvider.selectedPackageIndex == index,
                              onTap: () async{
                                AppLoader.showLoader(context);
                                packageProvider.setSelectedPackage(index: index);
                                await packageProvider.storeInitialPackageRequest(
                                  context, cityId: requestServicesProvider.cityIdData!.id!,
                                  packageId: packageProvider.packagesDataList[index].id!,
                                    vehicleId: myVehiclesProvider.myVehiclesData!.collection![widget.myVehicleIndex!].id!,
                                ).then((value) {
                                  if(value.status == Status.success){
                                    AppLoader.stopLoader();
                                    return navigateTo(context, WashesDate(packagesData: packageProvider.packagesDataList[index],),);
                                  }else{
                                    AppLoader.stopLoader();
                                    CustomSnackBars.failureSnackBar(
                                        context, '${value.message}');
                                  }

                                });

                              });
                        },
                        separatorBuilder: (context, index) => verticalSpace(16),
                      ),
                    ),
                    /*verticalSpace(16),
              CustomContainer(
                radiusCircular: 6,
                width: 345,
                height: 173,
                backgroundColor: AppColor.borderGreyLight,
                padding: EdgeInsets.zero,
                borderColor: const Color(0xFFCDCDCD),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomContainer(
                          width: 112,
                          height: 34,
                          radiusCircular: 0,
                          backgroundColor: const Color(0xFFB8B8B8),
                          child: Center(
                            child: TextWidget(
                              text: 'Golden PKG',
                              fontWeight: MyFontWeight.semiBold,
                              textSize: MyFontSize.size10,
                              color: const Color(0xFF363636),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                      symmetricEdgeInsets(horizontal: 18, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Washes:',
                                fontWeight: MyFontWeight.semiBold,
                                textSize: MyFontSize.size14,
                              ),
                              horizontalSpace(8),
                              RichText(
                                text: TextSpan(
                                  text: '4 times ',
                                  style: TextStyle(
                                      color: const Color(0xFF0096FF),
                                      fontSize: MyFontSize.size10,
                                      fontWeight: MyFontWeight.medium),
                                  children: [
                                    TextSpan(
                                      text: 'per month',
                                      style: TextStyle(
                                        color: const Color(0xFF636363),
                                        fontSize: MyFontSize.size10,
                                        fontWeight: MyFontWeight.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(16),
                          TextWidget(
                            text: 'Include for each appointment:',
                            fontWeight: MyFontWeight.semiBold,
                            textSize: MyFontSize.size14,
                          ),
                          verticalSpace(7),
                          TextWidget(
                            text: 'Inside and outside wash(!)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: const Color(0xFF636363),
                          ),
                          verticalSpace(16),
                          TextWidget(
                            text: '160 SR',
                            fontWeight: MyFontWeight.bold,
                            textSize: MyFontSize.size14,
                            color: AppColor.borderBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),*/
                  ],
                ),
              ));
  }
}

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.packageProvider,
    this.isSelected = false,
    required this.index,
    this.onTap,
  });

  final PackageProvider packageProvider;
  final bool isSelected;
  final int index;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      radiusCircular: 6,
      width: 345,
      height: 173,
      backgroundColor:
          isSelected ? AppColor.selectedColor : AppColor.borderGreyLight,
      padding: EdgeInsets.zero,
      borderColor: isSelected ? AppColor.babyBlue : const Color(0xFFCDCDCD),
      child: Column(
        children: [
          Row(
            children: [
              CustomContainer(
                width: 112,
                height: 34,
                radiusCircular: 0,
                backgroundColor: isSelected
                    ? const Color(0xFF9ACEF2)
                    : const Color(0xFFB8B8B8),
                child: Center(
                  child: TextWidget(
                    text: '${packageProvider.packagesDataList[index].name} PKG',
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size10,
                    color: isSelected
                        ? const Color(0xFF00567B)
                        : const Color(0xFF363636),
                  ),
                ),
              ),
              const Spacer(),
              Visibility(
                visible: isSelected,
                child: const Padding(
                  padding: EdgeInsetsDirectional.only(end: 13),
                  child: CustomSizedBox(
                    height: 18,
                    width: 18,
                    child: CircleAvatar(
                      backgroundColor: AppColor.babyBlue,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: symmetricEdgeInsets(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                Row(
                  children: [
                    TextWidget(
                      text: 'Washes:',
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size14,
                    ),
                    horizontalSpace(8),
                    RichText(
                      text: TextSpan(
                        text:
                            '${packageProvider.packagesDataList[index].washingQuantity} times ',
                        style: TextStyle(
                            color: const Color(0xFF0096FF),
                            fontSize: MyFontSize.size10,
                            fontWeight: MyFontWeight.medium),
                        children: [
                          TextSpan(
                            text:
                                'per ${packageProvider.packagesDataList[index].per}',
                            style: TextStyle(
                              color: const Color(0xFF636363),
                              fontSize: MyFontSize.size10,
                              fontWeight: MyFontWeight.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(16),
                TextWidget(
                  text: 'Include for each appointment:',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size14,
                ),
                verticalSpace(7),
                TextWidget(
                  text: '${packageProvider.packagesDataList[index].description}',
                  fontWeight: MyFontWeight.medium,
                  textSize: MyFontSize.size10,
                  color: const Color(0xFF636363),
                ),
                verticalSpace(16),
                TextWidget(
                  text:
                      '${packageProvider.packagesDataList[index].selectedPrice} SR',
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size14,
                  color: AppColor.borderBlue,
                ),

                /*
                verticalSpace(24),
                TextWidget(
                  text: '2nd wash',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size15,
                ),
                verticalSpace(12),
                CustomContainer(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  height: 75,
                  backgroundColor: AppColor.borderGreyLight,
                  child: Row(
                    children: [
                      const CustomContainer(
                        width: 8,
                        height: double.infinity,
                        radiusCircular: 0,
                        backgroundColor: Color(0xFF898A8D),
                      ),
                      Padding(
                        padding:
                        symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                        child: Row(
                          children: [
                            CustomContainer(
                              borderColor: const Color(0xFF979797),
                              height: 46,
                              width: 46,
                              backgroundColor: Colors.transparent,
                              radiusCircular: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/svg/about.svg',
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
                                      text: 'Monday, 22 January 2023',
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
                                      text: '03:15 PM',
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
                verticalSpace(24),
                TextWidget(
                  text: '3rd wash',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size15,
                ),
                verticalSpace(12),
                CustomContainer(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  height: 75,
                  backgroundColor: AppColor.borderGreyLight,
                  child: Row(
                    children: [
                      const CustomContainer(
                        width: 8,
                        height: double.infinity,
                        radiusCircular: 0,
                        backgroundColor: Color(0xFF898A8D),
                      ),
                      Padding(
                        padding:
                        symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                        child: Row(
                          children: [
                            CustomContainer(
                              borderColor: const Color(0xFF979797),
                              height: 46,
                              width: 46,
                              backgroundColor: Colors.transparent,
                              radiusCircular: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/svg/about.svg',
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
                                      text: 'Monday, 22 January 2023',
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
                                      text: '03:15 PM',
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
                verticalSpace(24),
                TextWidget(
                  text: '4th wash',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size15,
                ),
                verticalSpace(12),
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
                ),
                verticalSpace(24),
                */
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/*child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: '1st wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: 75,
                backgroundColor: AppColor.selectedColor,
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
                              child: SvgPicture.asset(
                                'assets/svg/about.svg',
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
                                    text: 'Monday, 22 January 2023',
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
                                    text: '03:15 PM',
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
              verticalSpace(24),
              TextWidget(
                text: '2nd wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: 75,
                backgroundColor: AppColor.borderGreyLight,
                child: Row(
                  children: [
                    const CustomContainer(
                      width: 8,
                      height: double.infinity,
                      radiusCircular: 0,
                      backgroundColor: Color(0xFF898A8D),
                    ),
                    Padding(
                      padding:
                          symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                      child: Row(
                        children: [
                          CustomContainer(
                            borderColor: const Color(0xFF979797),
                            height: 46,
                            width: 46,
                            backgroundColor: Colors.transparent,
                            radiusCircular: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/about.svg',
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
                                    text: 'Monday, 22 January 2023',
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
                                    text: '03:15 PM',
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
              verticalSpace(24),
              TextWidget(
                text: '3rd wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: 75,
                backgroundColor: AppColor.borderGreyLight,
                child: Row(
                  children: [
                    const CustomContainer(
                      width: 8,
                      height: double.infinity,
                      radiusCircular: 0,
                      backgroundColor: Color(0xFF898A8D),
                    ),
                    Padding(
                      padding:
                          symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                      child: Row(
                        children: [
                          CustomContainer(
                            borderColor: const Color(0xFF979797),
                            height: 46,
                            width: 46,
                            backgroundColor: Colors.transparent,
                            radiusCircular: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/about.svg',
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
                                    text: 'Monday, 22 January 2023',
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
                                    text: '03:15 PM',
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
              verticalSpace(24),
              TextWidget(
                text: '4th wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
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
              ),
              verticalSpace(24),
            ],
          ),*/