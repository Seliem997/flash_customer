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
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context);
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
                                          requestServicesProvider.cityIdData != null
                                              ? navigateTo(
                                              context,
                                              MonthlyPlans(
                                                comeFromNewCar: true,
                                                vehicleId: myVehiclesProvider
                                                    .vehicleDetailsData!.id,
                                                vehicleTypeId: myVehiclesProvider
                                                    .vehicleDetailsData!.vehicleTypeId!,
                                                vehicleSubTypeId: myVehiclesProvider
                                                    .vehicleDetailsData!.subVehicleTypeId!,
                                              ))
                                              : CustomSnackBars.failureSnackBar(
                                              context, 'Choose available City first');
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
                              ? requestServicesProvider.cityIdData != null
                          ?  navigateTo(
                          context,
                          MonthlyPlans(
                            myVehicleIndex: myVehiclesProvider
                                .selectedMyVehicleIndex,
                            vehicleTypeId: myVehiclesProvider
                                .myVehiclesData!
                                .collection![myVehiclesProvider
                                .selectedMyVehicleIndex!]
                                .vehicleTypeId!,
                            vehicleSubTypeId:  myVehiclesProvider
                                .myVehiclesData!
                                .collection![myVehiclesProvider
                                .selectedMyVehicleIndex!]
                                .subVehicleTypeId!,
                          ))
                          : CustomSnackBars.failureSnackBar(
                          context, 'Choose available City first')
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
