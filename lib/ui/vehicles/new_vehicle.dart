import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/manufacturersModel.dart';
import '../../models/vehiclesModelsModel.dart';
import '../../providers/myVehicles_provider.dart';
import '../../providers/package_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/font_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_field.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({Key? key}) : super(key: key);

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {

  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController numbersController = TextEditingController();
  TextEditingController lettersController = TextEditingController();
  // int manufacture=2, model=2;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context, listen: false);

    await packageProvider.getManufacturers();
  }

  @override
  Widget build(BuildContext context) {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context);
    final MyVehiclesProvider myVehiclesProvider =
        Provider.of<MyVehiclesProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Vehicle Info',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                      text: 'Manufacturer',
                      textSize: MyFontSize.size15,
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
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 44,
                radiusCircular: 3,
                borderColor: const Color(0xFF979797),
                backgroundColor: AppColor.borderGreyLight,
                padding: symmetricEdgeInsets(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: packageProvider.selectedManufacture,
                    iconEnabledColor: Colors.black,
                    hint: TextWidget(
                      text: 'Choose Manufacturer',
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
                                packageProvider
                                    .manufacturerDataList[index].name!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)))),
                    onChanged: (value) async {
                      packageProvider.setSelectedManufacture(value!);
                      // manufacture = value.vehicleTypeId!;
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
                      textSize: MyFontSize.size15,
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
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 44,
                radiusCircular: 3,
                padding: symmetricEdgeInsets(horizontal: 16),
                borderColor: const Color(0xFF979797),
                backgroundColor: AppColor.borderGreyLight,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: packageProvider.selectedVehicleModel,
                    iconEnabledColor: Colors.black,
                    hint: TextWidget(
                      text: 'Choose Model',
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
                            value:
                                packageProvider.vehiclesModelsDataList[index],
                            child: Text(
                                packageProvider
                                    .vehiclesModelsDataList[index].name!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)))),
                    onChanged: (value) async {
                      packageProvider.setSelectedVehicle(value!);
                      // model = value.id!;
                    },
                    menuMaxHeight: 25.h,
                  ),
                ),
              ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: 'Nickname',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: '(Optional)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              CustomSizedBox(
                height: 44,
                width: double.infinity,
                child: DefaultFormField(
                  controller: nameController,
                  hintText: 'Type name......',
                  fillColor: AppColor.borderGreyLight,
                  filled: true,
                  textColor: AppColor.textGrey,
                  textSize: MyFontSize.size12,
                  fontWeight: MyFontWeight.medium,
                ),
              ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: 'Year',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: '(Optional)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              CustomSizedBox(
                height: 44,
                width: double.infinity,
                child: DefaultFormField(
                  controller: yearController,
                  hintText: 'Enter Year',
                  fillColor: AppColor.borderGreyLight,
                  filled: true,
                  textColor: AppColor.textGrey,
                  textSize: MyFontSize.size12,
                  fontWeight: MyFontWeight.medium,
                ),
              ),
              verticalSpace(24),
              TextWidget(
                text: 'Color',
                textSize: MyFontSize.size15,
                fontWeight: MyFontWeight.medium,
              ),
              verticalSpace(12),
              Row(
                children: [
                  Expanded(
                    child: CustomSizedBox(
                      height: 25,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(right: 2.w),
                              child: const CircleAvatar(
                                backgroundColor: AppColor.black,
                                radius: 16,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFFF9900),
                                  radius: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_sharp)
                ],
              ),
              verticalSpace(54),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Numbers',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.medium,
                      ),
                      verticalSpace(12),
                      CustomSizedBox(
                        height: 44,
                        width: 160,
                        child: DefaultFormField(
                          controller: numbersController,
                          hintText: 'Type Numbers',
                          fillColor: AppColor.borderGreyLight,
                          filled: true,
                          textColor: AppColor.textGrey,
                          textSize: MyFontSize.size12,
                          fontWeight: MyFontWeight.medium,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  horizontalSpace(25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Letters',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.medium,
                      ),
                      verticalSpace(12),
                      CustomSizedBox(
                        height: 44,
                        width: 160,
                        child: DefaultFormField(
                          controller: lettersController,
                          hintText: 'Type Letters',
                          fillColor: AppColor.borderGreyLight,
                          filled: true,
                          textColor: AppColor.textGrey,
                          textSize: MyFontSize.size12,
                          fontWeight: MyFontWeight.medium,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(32),
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/vehicle_plate.png'),
              ),
              verticalSpace(12),
              Align(
                alignment: Alignment.center,
                child: TextWidget(
                  text: 'Vehicle registration plate',
                  textSize: MyFontSize.size14,
                  fontWeight: MyFontWeight.medium,
                  color: AppColor.grey,
                ),
              ),
              verticalSpace(56),
              DefaultButton(
                width: 345,
                height: 48,
                text: 'Save',
                fontSize: 21,
                fontWeight: MyFontWeight.bold,
                onPressed: () async{
                  AppLoader.showLoader(context);
                  await myVehiclesProvider.addNewVehicle(
                    vehicleTypeId: '1',
                    manufacture: packageProvider.selectedManufacture!.id!,
                    model: packageProvider.selectedVehicleModel!.id!,
                    numbers: numbersController.text,
                    letters: lettersController.text,
                    color: '0xFFdedede',
                    name: nameController.text,
                    year: yearController.text,
                  ).then((value) {
                    AppLoader.stopLoader();
                    navigateAndFinish(context, const HomeScreen());
                  });

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
