import 'package:flash_customer/main.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/enum/statuses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/home_provider.dart';
import '../../providers/myVehicles_provider.dart';
import '../../providers/package_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../../utils/font_styles.dart';
import 'washes_date.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class MonthlyPlans extends StatefulWidget {
  const MonthlyPlans(
      {Key? key,
      this.myVehicleIndex,
      this.comeFromNewCar = false,
      this.vehicleId,
        this.vehicleSubTypeId, this.vehicleTypeId})
      : super(key: key);

  final int? myVehicleIndex;
  final bool comeFromNewCar;
  final int? vehicleId;
  final int? vehicleTypeId;
  final int? vehicleSubTypeId;
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
    packageProvider.setLoading(true);
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    await requestServicesProvider.getCityId(
      lat: homeProvider.currentPosition!.latitude,
      long: homeProvider.currentPosition!.longitude,
    );
    await packageProvider.getPackages(
        cityId: requestServicesProvider.cityIdData!.id!,
      vehicleTypeId: widget.vehicleTypeId!,
      vehicleSubTypeId: widget.vehicleSubTypeId!
    ).then((value) => packageProvider.setLoading(false));
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
        appBar: CustomAppBar(title: S.of(context).monthlyPkg),
        body: packageProvider.isLoading
            ? const DataLoader()
        :packageProvider.packagesDataList.isEmpty
            ? const NoDataPlaceHolder(useExpand: false,)
            : Padding(
                padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: S.of(context).selectPackage,
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
                              isSelected:
                                  packageProvider.selectedPackageIndex == index,
                              onTap: () async {
                                AppLoader.showLoader(context);
                                packageProvider.setSelectedPackage(
                                    index: index);
                                await packageProvider
                                    .storeInitialPackageRequest(
                                  context,
                                  cityId:
                                      requestServicesProvider.cityIdData!.id!,
                                  packageId: packageProvider
                                      .packagesDataList[index].id!,
                                  vehicleId: widget.comeFromNewCar
                                      ? widget.vehicleId!
                                      : myVehiclesProvider
                                          .myVehiclesData!
                                          .collection![widget.myVehicleIndex!]
                                          .id!,
                                )
                                    .then((value) {
                                  if (value.status == Status.success) {
                                    AppLoader.stopLoader();
                                    packageProvider.washesTime = {};
                                    packageProvider.washesDate = {};
                                    return navigateTo(
                                      context,
                                      WashesDate(
                                        packagesData: packageProvider
                                            .packagesDataList[index],
                                      ),
                                    );
                                  } else {
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
      // height: 173,
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
                    text: '${packageProvider.packagesDataList[index].name}',
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
                      text: S.of(context).washes,
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size14,
                    ),
                    horizontalSpace(8),
                    RichText(
                      text: TextSpan(
                        text:
                            '${packageProvider.packagesDataList[index].washingQuantity} ${S.of(context).times} ',
                        style: TextStyle(
                            color: const Color(0xFF0096FF),
                            fontSize: MyFontSize.size10,
                            fontWeight: MyFontWeight.medium),
                        children: [
                          TextSpan(
                            text:
                                ' ${S.of(context).per} ${packageProvider.packagesDataList[index].per}',
                            style: TextStyle(
                              color: MyApp.themeMode(context) ? AppColor.white : const Color(0xFF636363),
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
                  text: S.of(context).includeForEachAppointment,
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size14,
                ),
                verticalSpace(7),
                TextWidget(
                  text: packageProvider.packagesDataList[index].description != null
                      ? packageProvider.packagesDataList[index].description!
                      : '',
                  fontWeight: MyFontWeight.medium,
                  textSize: MyFontSize.size10,
                  color: const Color(0xFF636363),
                ),
                verticalSpace(16),
                TextWidget(
                  text:
                      '${packageProvider.packagesDataList[index].selectedPrice} ${S.of(context).sr}',
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size14,
                  color: AppColor.borderBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
