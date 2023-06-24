import 'package:flash_customer/models/manufacturersModel.dart';
import 'package:flash_customer/models/vehiclesModelsModel.dart';
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
  const VehicleTypes({Key? key}) : super(key: key);

  @override
  State<VehicleTypes> createState() => _VehicleTypesState();
}

class _VehicleTypesState extends State<VehicleTypes> {
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

    await myVehiclesProvider
        .getMyVehicles()
        .then((value) => packageProvider.selectedMyVehicleLabel());
    packageProvider.getVehiclesTypeActive();
    packageProvider.getManufacturersOfType(
        vehicleTypeId: packageProvider.vehicleTypeId);
    requestServicesProvider.getCityId(
      context,
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
      appBar: const CustomAppBar(title: 'Vehicle Type'),
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
                  borderColorDark:
                  packageProvider.myVehicleLabel
                      ? AppColor.borderBlue
                      : null,
                  width: 162,
                  height: 50,
                  radiusCircular: 4,
                  onTap: () {
                    packageProvider.selectedMyVehicleLabel();
                  },
                  child: Center(
                    child: TextWidget(
                      text: 'My Vehicles',
                      fontWeight: packageProvider.myVehicleLabel
                          ? MyFontWeight.semiBold
                          : MyFontWeight.medium,
                      textSize: packageProvider.myVehicleLabel
                          ? MyFontSize.size16
                          : MyFontSize.size14,
                      color: packageProvider.myVehicleLabel
                          ? AppColor.black
                          : const Color(0xFF878787),
                    ),
                  ),
                ),
                horizontalSpace(21),
                CustomContainer(
                  backgroundColor: packageProvider.newVehicleLabel
                      ? AppColor.selectedColor
                      : AppColor.white,
                  borderColor: packageProvider.newVehicleLabel
                      ? AppColor.babyBlue
                      : AppColor.borderGrey,
                  borderColorDark:
                  packageProvider.newVehicleLabel
                      ? AppColor.borderBlue
                      : null,
                  width: 162,
                  height: 50,
                  radiusCircular: 4,
                  onTap: () {
                    packageProvider.selectedNewVehicleLabel();
                  },
                  child: Center(
                    child: TextWidget(
                      text: 'New Vehicles',
                      fontWeight: packageProvider.newVehicleLabel
                          ? MyFontWeight.semiBold
                          : MyFontWeight.medium,
                      textSize: packageProvider.newVehicleLabel
                          ? MyFontSize.size16
                          : MyFontSize.size14,
                      color: packageProvider.newVehicleLabel
                          ? AppColor.black
                          : const Color(0xFF878787),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(20),
            packageProvider.newVehicleLabel
                ? (packageProvider.vehiclesTypesDataList.isEmpty ||
                        packageProvider.manufacturerDataList.isEmpty)
                    ? const DataLoader()
                    : Expanded(
                        child: NewVehiclesScreenWidget(
                            packageProvider: packageProvider),
                      )
                : myVehiclesProvider.loadingMyVehicles
                    ? const DataLoader(useExpand: true)
                    : myVehiclesProvider.myVehiclesData == null
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
              text: 'Next',
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
                                  vehicleTypeId: '1',
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
                                    navigateTo(
                                      context,
                                      ServicesScreen(
                                        cityId: requestServicesProvider
                                            .cityIdData!.id!,
                                        vehicleId: myVehiclesProvider
                                            .vehicleDetailsData!.id!,
                                      ),
                                    );
                                  } else {
                                    CustomSnackBars.somethingWentWrongSnackBar(
                                        context);
                                  }
                                }),
                              }
                            : packageProvider.chooseRequiredModel(value: true)
                        : packageProvider.chooseRequiredManufacture(value: true)
                    : myVehiclesProvider.selectedMyVehicleIndex != null
                        ? navigateTo(
                            context,
                            ServicesScreen(
                              cityId: requestServicesProvider.cityIdData!.id!,
                              vehicleId: myVehiclesProvider
                                  .myVehiclesData!
                                  .collection![myVehiclesProvider
                                      .selectedMyVehicleIndex!]
                                  .id!,
                            ),
                          )
                        : CustomSnackBars.failureSnackBar(
                            context, 'Choose Vehicle First');
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
              borderColorDark:
              packageProvider.selectedVehicleTypeIndex == index
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
                  CustomSizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                        packageProvider.vehiclesTypesDataList[index].image!),
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
        /* Row(
          children: [
            CustomContainer(
              backgroundColor: const Color(0xFFE6EEFB),
              width: 105,
              height: 112,
              padding: symmetricEdgeInsets(horizontal: 24, vertical: 19),
              onTap: () {},
              radiusCircular: 5,
              child: Column(
                children: [
                  CustomSizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(packageProvider.vehiclesTypesDataList[0].image!),
                  ),
                  verticalSpace(8),
                  TextWidget(
                    text: 'Car',
                    fontWeight: MyFontWeight.bold,
                    textSize: MyFontSize.size14,
                  ),
                ],
              ),
            ),
            horizontalSpace(11),
            CustomContainer(
              backgroundColor: AppColor.borderGreyLight,
              width: 105,
              height: 112,
              padding: symmetricEdgeInsets(horizontal: 24, vertical: 19),
              onTap: () {},
              radiusCircular: 5,
              child: Column(
                children: [
                  CustomSizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/vehicle_van.png'),
                  ),
                  verticalSpace(8),
                  TextWidget(
                    text: 'Van',
                    fontWeight: MyFontWeight.medium,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
            ),
            horizontalSpace(11),
            CustomContainer(
              backgroundColor: AppColor.borderGreyLight,
              width: 108,
              height: 112,
              padding: symmetricEdgeInsets(horizontal: 14, vertical: 19),
              onTap: () {},
              radiusCircular: 5,
              child: Column(
                children: [
                  CustomSizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/vehicle_motorcycle.png'),
                  ),
                  verticalSpace(8),
                  TextWidget(
                    text: 'Motorcycle',
                    fontWeight: MyFontWeight.medium,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
            ),
          ],
        ),*/
        verticalSpace(38),
        Row(
          children: [
            TextWidget(
                text: 'Select Manufacturer',
                textSize: MyFontSize.size18,
                fontWeight: MyFontWeight.medium),
            horizontalSpace(6),
            TextWidget(
              text: '(Required)',
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
                text: 'Select',
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
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16)))),
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
                text: 'Model',
                textSize: MyFontSize.size18,
                fontWeight: MyFontWeight.medium),
            horizontalSpace(6),
            TextWidget(
              text: '(Required)',
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
                text: 'Select',
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
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16))),
              ),
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
