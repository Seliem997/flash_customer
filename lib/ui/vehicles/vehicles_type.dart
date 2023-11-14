import 'package:flash_customer/models/manufacturersModel.dart';
import 'package:flash_customer/models/vehiclesModelsModel.dart';
import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/no_data_place_holder.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/home_provider.dart';
import '../../providers/myVehicles_provider.dart';
import '../../providers/package_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/styles/colors.dart';
import '../services/services_screen.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';
import 'my_vehicles.dart';

class VehicleTypes extends StatefulWidget {
  const VehicleTypes({Key? key,}) : super(key: key);

  @override
  State<VehicleTypes> createState() => _VehicleTypesState();
}

class _VehicleTypesState extends State<VehicleTypes> {
  final GlobalKey listVehiclesKey= GlobalKey();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context, listen: false);
    final MyVehiclesProvider myVehiclesProvider =
        Provider.of<MyVehiclesProvider>(context, listen: false);
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    await myVehiclesProvider.getMyVehicles().then((value) {
      if (myVehiclesProvider.myVehiclesData!.collection!.isNotEmpty) {
        packageProvider.selectedMyVehicleLabel();
      }
    });
    packageProvider.getVehiclesTypeActive();
    packageProvider.getManufacturersOfType(
        vehicleTypeId: packageProvider.vehicleTypeId);
    requestServicesProvider.getCityId(
      lat: homeProvider.currentPosition!.latitude,
      long: homeProvider.currentPosition!.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context);
    final MyVehiclesProvider myVehiclesProvider =
        Provider.of<MyVehiclesProvider>(context);
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
          title: S.of(context).vehicleType,

      ),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          children: [
            Row(
              children: [
                CustomContainer(
                  backgroundColor: packageProvider.myVehicleLabel
                      ? AppColor.selectedColor
                      : AppColor.white,
                  borderColor: packageProvider.myVehicleLabel
                      ? AppColor.babyBlue
                      : AppColor.borderGrey,
                  borderColorDark: packageProvider.myVehicleLabel
                      ? AppColor.borderBlue
                      : null,
                  backgroundColorDark: packageProvider.myVehicleLabel
                      ? AppColor.grey
                      : null,
                  width: 162,
                  padding: symmetricEdgeInsets(vertical: 10),
                  radiusCircular: 6,
                  onTap: () {
                    packageProvider.selectedMyVehicleLabel();
                  },
                  child: Column(
                    children: [
                      CustomSizedBox(
                        width: 50,
                        height: 50,
                        child:
                        Image.asset('assets/images/my_vehicles.png'),
                      ),
                      verticalSpace(8),
                      TextWidget(
                        text: S.of(context).myVehicles,
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size18,
                      ),
                    ],
                  ),
                  // child: Center(
                  //   child: TextWidget(
                  //     text: S.of(context).myVehicles,
                  //     fontWeight: packageProvider.myVehicleLabel
                  //         ? MyFontWeight.semiBold
                  //         : MyFontWeight.medium,
                  //     textSize: packageProvider.myVehicleLabel
                  //         ? MyFontSize.size16
                  //         : MyFontSize.size14,
                  //     color: packageProvider.myVehicleLabel
                  //         ? AppColor.black
                  //         : const Color(0xFF878787),
                  //   ),
                  // ),
                ),
                horizontalSpace(21),
                CustomContainer(
                  backgroundColor: packageProvider.newVehicleLabel
                      ? AppColor.selectedColor
                      : AppColor.white,
                  borderColor: packageProvider.newVehicleLabel
                      ? AppColor.babyBlue
                      : AppColor.borderGrey,
                  borderColorDark: packageProvider.newVehicleLabel
                      ? AppColor.borderBlue
                      : null,
                  backgroundColorDark: packageProvider.newVehicleLabel
                      ? AppColor.grey : null,
                  width: 162,
                  padding: symmetricEdgeInsets(vertical: 10),
                  radiusCircular: 6,
                  onTap: () {
                    packageProvider.selectedNewVehicleLabel();
                  },
                  child: Column(
                    children: [
                      CustomSizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/new_car.png'),
                      ),
                      verticalSpace(8),
                      TextWidget(
                        text: S.of(context).newCar,
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size18,
                      )
                    ],
                  ),
                  // child: Center(
                  //   child: TextWidget(
                  //     text: S.of(context).newVehicles,
                  //     fontWeight: packageProvider.newVehicleLabel
                  //         ? MyFontWeight.semiBold
                  //         : MyFontWeight.medium,
                  //     textSize: packageProvider.newVehicleLabel
                  //         ? MyFontSize.size16
                  //         : MyFontSize.size14,
                  //     color: packageProvider.newVehicleLabel
                  //         ? AppColor.black
                  //         : const Color(0xFF878787),
                  //   ),
                  // ),
                ),
              ],
            ),
            verticalSpace(20),
            packageProvider.newVehicleLabel
                ? (packageProvider.vehiclesTypesDataList.isEmpty ||
                        packageProvider.manufacturerDataList.isEmpty)
                    ? const DataLoader(
                        useExpand: true,
                      )
                    : Expanded(
                        child: NewVehiclesScreenWidget(
                            packageProvider: packageProvider),
                      )
                : myVehiclesProvider.loadingMyVehicles
                    ? const DataLoader(useExpand: true)
                    : myVehiclesProvider.myVehiclesData!.collection!.isEmpty
                        ? const NoDataPlaceHolder()
                        : MyVehiclesScreenWidget(
                            myVehiclesProvider: myVehiclesProvider),
            packageProvider.newVehicleLabel
                ? Visibility(
                    visible: packageProvider.manufacturerDataList.isEmpty,
                    child: const Spacer(),
                  )
                : Visibility(
                    visible: myVehiclesProvider.myVehiclesData == null,
                    child: const Spacer(),
                  ),
            DefaultButton(
              height: 48,
              width: double.infinity,
              fontWeight: MyFontWeight.bold,
              fontSize: MyFontSize.size20,
              text: S.of(context).next,
              onPressed: () async {
                requestServicesProvider.clearServices();
                packageProvider.newVehicleLabel
                    ? packageProvider.chooseManufacture
                        ? packageProvider.chooseModel
                            ? {
                                packageProvider.clearBorder(),
                                AppLoader.showLoader(context),
                                await myVehiclesProvider
                                    .addNewVehicle(
                                  vehicleTypeId: packageProvider
                                      .selectedManufacture!.vehicleTypeId!,
                                  manufacture:
                                      packageProvider.selectedManufacture!.id!,
                                  model:
                                      packageProvider.selectedVehicleModel!.id!,
                                  name: packageProvider
                                      .selectedVehicleModel!.name!,
                                )
                                    .then((value) {
                                  AppLoader.stopLoader();
                                  if (value.status == Status.success) {
                                    CustomSnackBars.successSnackBar(
                                        context, 'New Vehicle added');
                                    requestServicesProvider
                                        .cityIdData != null ?
                                    navigateTo(
                                      context,
                                      ServicesScreen(
                                        cityId: requestServicesProvider
                                            .cityIdData!.id!,
                                        vehicleId: myVehiclesProvider
                                            .vehicleDetailsData!.id!,
                                      ),
                                    ) : CustomSnackBars.failureSnackBar(
                                        context, 'This City not available');
                                  } else {
                                    CustomSnackBars.somethingWentWrongSnackBar(
                                        context);
                                  }
                                }),
                              }
                            : packageProvider.chooseRequiredModel(value: true)
                        : packageProvider.chooseRequiredManufacture(value: true)
                    : myVehiclesProvider.selectedMyVehicleIndex != null
                        ? requestServicesProvider.cityIdData != null
                            ? navigateTo(
                                context,
                                ServicesScreen(
                                  cityId:
                                      requestServicesProvider.cityIdData!.id!,
                                  vehicleId: myVehiclesProvider
                                      .myVehiclesData!
                                      .collection![myVehiclesProvider
                                          .selectedMyVehicleIndex!]
                                      .id!,
                                ),
                              )
                            : CustomSnackBars.failureSnackBar(
                                context, S.of(context).chooseAvailableCityFirst)
                        : CustomSnackBars.failureSnackBar(
                            context, S.of(context).chooseVehicleFirst);
              },
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}

class NewVehiclesScreenWidget extends StatelessWidget {
  const NewVehiclesScreenWidget({
    super.key,
    required this.packageProvider,
  });

  final PackageProvider packageProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSizedBox(
          height: 115,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: packageProvider.vehiclesTypesDataList.length,
            itemBuilder: (context, index) => CustomContainer(
              backgroundColor: packageProvider.selectedVehicleTypeIndex == index
                  ? const Color(0xFFE6EEFB)
                  : AppColor.borderGreyLight,
              backgroundColorDark: packageProvider.selectedVehicleTypeIndex == index
                  ? AppColor.grey
                  : AppColor.primaryDark,
              borderColorDark: packageProvider.selectedVehicleTypeIndex == index
                  ? AppColor.borderBlue
                  : null,
              width: 105,
              height: 112,
              padding: symmetricEdgeInsets(horizontal: 4, vertical: 19),
              onTap: () async {
                packageProvider.setSelectedVehicleType(index: index);
                packageProvider.setVehicleTypeId(typeId: (index + 1));
                AppLoader();
                await packageProvider
                    .getManufacturersOfType(
                        vehicleTypeId: packageProvider.vehicleTypeId)
                    .then((value) {
                  AppLoader.stopLoader();
                });
              },
              radiusCircular: 5,
              child: Column(
                children: [
                  Expanded(
                    child: CustomSizedBox(
                      // width: 50,
                      // height: 50,
                      child: Image.network(
                          packageProvider.vehiclesTypesDataList[index].image!,fit: BoxFit.cover,),
                    ),
                  ),
                  verticalSpace(8),
                  TextWidget(
                    text: packageProvider.vehiclesTypesDataList[index].name!,
                    fontWeight: MyFontWeight.medium,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => horizontalSpace(11),
          ),
        ),
        verticalSpace(38),
        Row(
          children: [
            TextWidget(
                text: S.of(context).selectManufacturer,
                textSize: MyFontSize.size18,
                fontWeight: MyFontWeight.medium),
            horizontalSpace(6),
            TextWidget(
              text: S.of(context).required,
              textSize: MyFontSize.size8,
              fontWeight: MyFontWeight.regular,
              color: packageProvider.requiredManufacture
                  ? Colors.red
                  : AppColor.lightGrey,
            ),
          ],
        ),
        verticalSpace(10),
        CustomContainer(
          width: double.infinity,
          height: 40,
          radiusCircular: 3,
          borderColor: packageProvider.requiredManufacture
              ? Colors.red
              : const Color(0xFF979797),
          backgroundColor: AppColor.borderGreyLight,
          padding: symmetricEdgeInsets(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: packageProvider.selectedManufacture,
              iconEnabledColor: Colors.black,
              hint: TextWidget(
                text: S.of(context).select,
                fontWeight: MyFontWeight.medium,
                textSize: MyFontSize.size10,
                color: const Color(0xFF909090),
              ),
              icon: SvgPicture.asset(
                'assets/svg/arrow_down.svg',
              ),
              items: List.generate(
                  packageProvider.manufacturerDataList.length,
                  (index) => DropdownMenuItem<ManufacturerData>(
                      value: packageProvider.manufacturerDataList[index],
                      child: Text(
                          packageProvider.manufacturerDataList[index].name!,
                          style: TextStyle(
                              color: MyApp.themeMode(context)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16)))),
              dropdownColor:
                  MyApp.themeMode(context) ? AppColor.grey : null,
              onChanged: (value) async {
                packageProvider.setSelectedManufacture(value!);
                packageProvider.chooseManufacture = true;
                packageProvider.chooseRequiredManufacture(value: false);
                AppLoader.showLoader(context);
                await packageProvider
                    .getVehiclesModels(
                        context: context, manufactureId: value.id!)
                    .then((result) {
                  // packageProvider.chooseManufacture = false;
                  AppLoader.stopLoader();
                });
              },
              menuMaxHeight: 25.h,
            ),
          ),
        ),
        verticalSpace(24),
        Row(
          children: [
            TextWidget(
                text: S.of(context).model,
                textSize: MyFontSize.size18,
                fontWeight: MyFontWeight.medium),
            horizontalSpace(6),
            TextWidget(
              text: S.of(context).required,
              textSize: MyFontSize.size8,
              fontWeight: MyFontWeight.regular,
              color: packageProvider.requiredModel
                  ? Colors.red
                  : AppColor.lightGrey,
            ),
          ],
        ),
        verticalSpace(10),
        CustomContainer(
          width: double.infinity,
          height: 40,
          radiusCircular: 3,
          padding: symmetricEdgeInsets(horizontal: 16),
          borderColor: packageProvider.requiredModel
              ? Colors.red
              : const Color(0xFF979797),
          backgroundColor: AppColor.borderGreyLight,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: packageProvider.selectedVehicleModel,
              iconEnabledColor: Colors.black,
              hint: TextWidget(
                text: S.of(context).select,
                fontWeight: MyFontWeight.medium,
                textSize: MyFontSize.size10,
                color: const Color(0xFF909090),
              ),
              icon: SvgPicture.asset(
                'assets/svg/arrow_down.svg',
              ),
              items: List.generate(
                packageProvider.vehiclesModelsDataList.length,
                (index) => DropdownMenuItem<VehiclesModelsData>(
                    value: packageProvider.vehiclesModelsDataList[index],
                    child: Text(
                        packageProvider.vehiclesModelsDataList[index].name!,
                        style: TextStyle(
                            color: MyApp.themeMode(context)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16))),
              ),
              dropdownColor:
                  MyApp.themeMode(context) ? AppColor.grey : null,
              onChanged: (value) async {
                packageProvider.setSelectedVehicle(value!);
                packageProvider.chooseModel = true;
                packageProvider.chooseRequiredModel(value: false);
              },
              menuMaxHeight: 25.h,
            ),
          ),
        ),
      ],
    );
  }
}
