import 'package:flash_customer/models/manufacturersModel.dart';
import 'package:flash_customer/models/vehiclesModelsModel.dart';
import 'package:flash_customer/ui/monthly_pkg/plan.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/package_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/styles/colors.dart';
import '../../utils/enum/statuses.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';

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
    final PackageProvider packageProvider=Provider.of<PackageProvider>(context, listen: false);

    await packageProvider.getManufacturers();
  }

  @override
  Widget build(BuildContext context) {
    final PackageProvider packageProvider=Provider.of<PackageProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Vehicle Type'),
      body: packageProvider.manufacturerDataList.isEmpty
          ? const DataLoader()
          : Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          children: [
            Row(
              children: [
                CustomContainer(
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.borderGrey,
                  width: 162,
                  height: 50,
                  radiusCircular: 4,
                  child: Center(
                    child: TextWidget(
                      text: 'My Vehicles',
                      fontWeight: MyFontWeight.medium,
                      textSize: MyFontSize.size14,
                      color: const Color(0xFF878787),
                    ),
                  ),
                ),
                horizontalSpace(21),
                CustomContainer(
                  backgroundColor: AppColor.selectedColor,
                  borderColor: AppColor.babyBlue,
                  width: 162,
                  height: 50,
                  radiusCircular: 4,
                  child: Center(
                    child: TextWidget(
                      text: 'New Vehicles',
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size16,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(33),
            Row(
              children: [
                CustomContainer(
                  backgroundColor: const Color(0xFFE6EEFB),
                  width: 105,
                  height: 112,
                  padding: symmetricEdgeInsets(horizontal: 24, vertical: 19),
                  onTap: (){},
                  radiusCircular: 5,
                  child: Column(
                    children: [
                      CustomSizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/vehicle_car.png'),),
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
                  onTap: (){},
                  radiusCircular: 5,
                  child: Column(
                    children: [
                      CustomSizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/vehicle_van.png'),),
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
                  onTap: (){},
                  radiusCircular: 5,
                  child: Column(
                    children: [
                      CustomSizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/vehicle_motorcycle.png'),),
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
            ),
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
              backgroundColor: const Color(0xFFECECEC),
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
                      packageProvider
                          .manufacturerDataList.length,
                          (index) => DropdownMenuItem<ManufacturerData>(
                          value: packageProvider
                              .manufacturerDataList[index],
                          child: Text(
                              packageProvider
                                  .manufacturerDataList[index].name!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16)))),
                  onChanged: (value) async {
                    packageProvider
                        .setSelectedManufacture(value!);
                    AppLoader.showLoader(context);
                    print('value.id! is 000000');
                    print(value.id!);
                    await packageProvider
                        .getVehiclesModels(manufactureId: value.id!)
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
              padding: symmetricEdgeInsets(horizontal: 16),
              borderColor: const Color(0xFF979797),
              backgroundColor: const Color(0xFFECECEC),
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
                      packageProvider
                          .vehiclesModelsDataList.length,
                          (index) => DropdownMenuItem<VehiclesModelsData>(
                          value: packageProvider
                              .vehiclesModelsDataList[index],
                          child: Text(
                              packageProvider
                                  .vehiclesModelsDataList[index].name!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16)))),
                  onChanged: (value) async {
                    packageProvider
                        .setSelectedVehicle(value!);
                  },
                  menuMaxHeight: 25.h,
                ),
              ),
            ),

            verticalSpace(72),
            DefaultButton(
              height: 48,
              width: double.infinity,
              fontWeight: MyFontWeight.bold,
              fontSize: MyFontSize.size20,
              text: 'Next',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return AlertDialog(
                    //   content: Padding(
                    //     padding: onlyEdgeInsets(top: 40,bottom: 32, end: 38, start: 38),
                    //     child: TextWidget(
                    //       textAlign: TextAlign.center,
                    //       text: 'Management will edit vehicle size as price will depends on the vehicle size',
                    //       textSize: MyFontSize.size17,
                    //       fontWeight: MyFontWeight.semiBold,
                    //     ),
                    //   ),
                    //   actions: [
                    //     Padding(
                    //       padding: onlyEdgeInsets(top: 0,bottom: 40, end: 48, start: 48),
                    //       child: DefaultButton(
                    //         width: 225,
                    //         height: 32,
                    //         text: 'Ok',
                    //         onPressed: (){
                    //           Navigator.pop(context);
                    //           },
                    //       ),
                    //     ),
                    //
                    //   ],
                    // );
                    return AlertDialog(
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
                                height: 32,
                                text: 'Back',
                                onPressed: () {
                                  navigateTo(context, const MonthlyPlans());
                                },
                              ),
                              verticalSpace(12),
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
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
