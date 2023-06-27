import 'package:flash_customer/ui/monthly_pkg/plan.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/home_provider.dart';
import '../../providers/myVehicles_provider.dart';
import '../../providers/package_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../../utils/enum/statuses.dart';
import '../vehicles/my_vehicles.dart';
import '../vehicles/vehicles_type.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';

class MonthlyPkg extends StatefulWidget {
  const MonthlyPkg({Key? key}) : super(key: key);

  @override
  State<MonthlyPkg> createState() => _MonthlyPkgState();
}

class _MonthlyPkgState extends State<MonthlyPkg> {
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

    await packageProvider.getManufacturers();
    await myVehiclesProvider.getMyVehicles().then((value) => myVehiclesProvider.myVehiclesData!.collection!.isNotEmpty
        ? packageProvider.selectedMyVehicleLabel()
        : packageProvider.selectedNewVehicleLabel(),
    );
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
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).monthlyPkg),
      body: packageProvider.manufacturerDataList.isEmpty
          ? const DataLoader()
          : Padding(
              padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomContainer(
                        padding:
                            symmetricEdgeInsets(horizontal: 18, vertical: 15),
                        backgroundColor: packageProvider.newVehicleLabel
                            ? AppColor.borderGrey
                            : AppColor.borderGreyLight,
                        borderColor: packageProvider.newVehicleLabel
                            ? AppColor.babyBlue
                            : Colors.transparent,
                        borderColorDark:
                        packageProvider.newVehicleLabel
                            ? AppColor.borderBlue
                            : null,
                        width: 162,
                        height: 112,
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
                      ),
                      horizontalSpace(21),
                      CustomContainer(
                        backgroundColor: packageProvider.myVehicleLabel
                            ? AppColor.borderGrey
                            : AppColor.borderGreyLight,
                        borderColor: packageProvider.myVehicleLabel
                            ? AppColor.babyBlue
                            : Colors.transparent,
                        borderColorDark:
                        packageProvider.myVehicleLabel
                            ? AppColor.borderBlue
                            : null,
                        width: 162,
                        height: 112,
                        padding:
                            symmetricEdgeInsets(horizontal: 18, vertical: 15),
                        onTap: () {
                          packageProvider.selectedMyVehicleLabel();
                        },
                        radiusCircular: 6,
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
                      ),
                    ],
                  ),
                  /*verticalSpace(56),
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
                        color: AppColor.lightGrey,
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: double.infinity,
                    height: 40,
                    radiusCircular: 3,
                    borderColor: const Color(0xFF979797),
                    backgroundColor: AppColor.borderGreyLight,
                    padding: symmetricEdgeInsets(horizontal: 20),
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
                                value:
                                    packageProvider.manufacturerDataList[index],
                                child: Text(
                                    packageProvider
                                        .manufacturerDataList[index].name!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)))),
                        onChanged: (value) async {
                          packageProvider.setSelectedManufacture(value!);
                          AppLoader.showLoader(context);
                          await packageProvider
                              .getVehiclesModels(context: context,manufactureId: value.id!)
                              .then((result) {
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
                        color: AppColor.lightGrey,
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: double.infinity,
                    height: 40,
                    radiusCircular: 3,
                    borderColor: const Color(0xFF979797),
                    backgroundColor: AppColor.borderGreyLight,
                    padding: symmetricEdgeInsets(horizontal: 20),
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
                                value: packageProvider
                                    .vehiclesModelsDataList[index],
                                child: Text(
                                    packageProvider
                                        .vehiclesModelsDataList[index].name!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)))),
                        onChanged: (value) async {
                          packageProvider.setSelectedVehicle(value!);
                        },
                        menuMaxHeight: 25.h,
                      ),
                    ),
                  ),
                  verticalSpace(72),*/
                  verticalSpace(20),
                  packageProvider.newVehicleLabel
                      ? (packageProvider.manufacturerDataList.isEmpty)
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
                    text: S.of(context).next,
                    onPressed: () async {
                      packageProvider.newVehicleLabel
                          ? packageProvider.chooseManufacture
                              ? packageProvider.chooseModel
                                  ? {
                                      packageProvider.clearBorder(),
                                      AppLoader.showLoader(context),
                                      await myVehiclesProvider
                                          .addNewVehicle(
                                        vehicleTypeId: packageProvider.selectedManufacture!.vehicleTypeId!,
                                        manufacture: packageProvider
                                            .selectedManufacture!.id!,
                                        model: packageProvider
                                            .selectedVehicleModel!.id!,
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
                                              MonthlyPlans(
                                                comeFromNewCar: true,
                                                vehicleId: myVehiclesProvider
                                                    .vehicleDetailsData!.id,
                                              ));
                                        } else {
                                          CustomSnackBars
                                              .somethingWentWrongSnackBar(
                                                  context);
                                        }
                                      }),
                                    }
                                  : packageProvider.chooseRequiredModel(
                                      value: true)
                              : packageProvider.chooseRequiredManufacture(
                                  value: true)
                          : myVehiclesProvider.selectedMyVehicleIndex != null
                              ? navigateTo(
                                  context,
                                  MonthlyPlans(
                                    myVehicleIndex: myVehiclesProvider
                                        .selectedMyVehicleIndex,
                                  ))
                              : CustomSnackBars.failureSnackBar(
                                  context, S.of(context).chooseVehicleFirst);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

/* return AlertDialog(
                      title: TextWidget(
                        textAlign: TextAlign.center,
                        text: 'The packages is not available now',
                        textSize: MyFontSize.size17,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      content: Padding(
                        padding: symmetricEdgeInsets(horizontal: 60),
                        child: TextWidget(
                          textAlign: TextAlign.center,
                          text: 'Please try again later or contact us for help',
                          textSize: MyFontSize.size16,
                          fontWeight: MyFontWeight.medium,
                          color: const Color(0xFF9F9F9F),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding:
                              onlyEdgeInsets(bottom: 40, end: 48, start: 48),
                          child: Column(
                            children: [
                              DefaultButton(
                                width: 225,
                                height: 40,
                                text: 'Back',
                                onPressed: () {
                                  navigateTo(context, const MonthlyPlans());
                                },
                              ),
                              verticalSpace(10),
                              TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  } ,
                                  child: TextWidget(
                                    text: 'Contact us',
                                    textSize: MyFontSize.size14,
                                    fontWeight: MyFontWeight.semiBold,
                                    color: const Color(0xFF7A7A7A),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    );*/

/* تحذير لو مفيش باكدج مناسبة
* showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Padding(
                                  padding: onlyEdgeInsets(
                                      top: 40, bottom: 32, end: 38, start: 38),
                                  child: TextWidget(
                                    textAlign: TextAlign.center,
                                    text:
                                        'Management will edit vehicle size as price will depends on the vehicle size',
                                    textSize: MyFontSize.size17,
                                    fontWeight: MyFontWeight.semiBold,
                                  ),
                                ),
                                actions: [
                                  Padding(
                                    padding: onlyEdgeInsets(
                                        top: 0, bottom: 40, end: 48, start: 48),
                                    child: DefaultButton(
                                      width: 225,
                                      height: 32,
                                      text: 'Ok',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );*/

/* onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Padding(
                              padding: onlyEdgeInsets(
                                  top: 40, bottom: 32, end: 38, start: 38),
                              child: TextWidget(
                                textAlign: TextAlign.center,
                                text:
                                    'Management will edit vehicle size as price will depends on the vehicle size',
                                textSize: MyFontSize.size17,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                            ),
                            actions: [
                              Padding(
                                padding: onlyEdgeInsets(
                                    top: 0, bottom: 40, end: 48, start: 48),
                                child: DefaultButton(
                                  width: 225,
                                  height: 32,
                                  text: 'Ok',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    navigateTo(context, const MonthlyPlans());
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },*/
