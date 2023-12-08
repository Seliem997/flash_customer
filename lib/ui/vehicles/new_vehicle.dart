import 'dart:developer';

import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../models/manufacturersModel.dart';
import '../../models/vehiclesModelsModel.dart';
import '../../providers/myVehicles_provider.dart';
import '../../providers/package_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/font_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_field.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({Key? key, this.updateVehicle = false, this.index,}) : super(key: key);

  final bool updateVehicle;
  final int? index;
  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {

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
    await packageProvider.getManufacturers();
    if(widget.updateVehicle){
      var vehicleData= myVehiclesProvider.myVehiclesData!.collection![widget.index!];
      myVehiclesProvider.nameController = vehicleData.name == null? TextEditingController(text: '') : TextEditingController(text: vehicleData.name);
      myVehiclesProvider.yearController = vehicleData.year == null? TextEditingController(text: '') : TextEditingController(text: vehicleData.year);
      myVehiclesProvider.numbersController = vehicleData.numbers == null? TextEditingController(text: '') : TextEditingController(text: vehicleData.numbers);
      myVehiclesProvider.lettersController = vehicleData.letters == null? TextEditingController(text: '') : TextEditingController(text: vehicleData.letters);
      myVehiclesProvider.screenPickerColor = vehicleData.color == null ? Colors.white : Color(int.parse(vehicleData.color!));
    }//
  }

  @override
  Widget build(BuildContext context) {
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context);
    final MyVehiclesProvider myVehiclesProvider =
        Provider.of<MyVehiclesProvider>(context);
    var vehicleData;
    if(widget.updateVehicle ) {
      vehicleData= myVehiclesProvider.myVehiclesData!.collection![widget.index!];
    }else;

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).vehicleInfo,
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
                      text: S.of(context).manufacturer,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).required,
                    textSize: MyFontSize.size12,
                    fontWeight: MyFontWeight.regular,
                    color: packageProvider.requiredManufacture
                        ? Colors.red
                        : AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 44,
                radiusCircular: 3,
                borderColor: packageProvider.requiredManufacture
                    ? Colors.red
                    : const Color(0xFF979797),
                backgroundColor: AppColor.borderGreyLight,
                borderColorDark: packageProvider.requiredManufacture
                    ? Colors.red
                    : const Color(0xFF979797),
                padding: symmetricEdgeInsets(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: packageProvider.selectedManufacture,
                    iconEnabledColor: Colors.black,
                    hint: TextWidget(
                      text: widget.updateVehicle ? vehicleData.manufacturerName! : S.of(context).chooseManufacturer,
                      fontWeight: MyFontWeight.medium,
                      textSize: MyFontSize.size12,
                      color: const Color(0xFF909090),
                    ),
                    icon: SvgPicture.asset(
                      'assets/svg/arrow_down.svg',
                    ),
                    dropdownColor: MyApp.themeMode(context)
                        ? AppColor.borderGreyLight
                        : null,
                    items: List.generate(
                        packageProvider.manufacturerDataList.length,
                        (index) => DropdownMenuItem<ManufacturerData>(
                            value: packageProvider.manufacturerDataList[index],
                            child: Text(
                                packageProvider
                                    .manufacturerDataList[index].name!,
                                style: TextStyle(
                                    color: MyApp.themeMode(context)
                                        ? const Color(0xFF909090)
                                        : Colors.black,
                                    fontSize: 18)))),
                    onChanged: (value) async {
                      packageProvider.setSelectedManufacture(value!);
                      packageProvider.chooseManufacture = true;
                      packageProvider.chooseRequiredManufacture(value: false);
                      // manufacture = value.vehicleTypeId!;
                      AppLoader.showLoader(context);

                      await packageProvider
                          .getVehiclesModels(
                              context: context, manufactureId: value.id!)
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
                      text: S.of(context).model,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).required,
                    textSize: MyFontSize.size12,
                    fontWeight: MyFontWeight.regular,
                    color: packageProvider.requiredModel
                        ? Colors.red
                        : AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 44,
                radiusCircular: 3,
                padding: symmetricEdgeInsets(horizontal: 16),
                borderColor: packageProvider.requiredModel
                    ? Colors.red
                    : const Color(0xFF979797),
                borderColorDark: packageProvider.requiredModel
                    ? Colors.red
                    : const Color(0xFF979797),
                backgroundColor: AppColor.borderGreyLight,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: packageProvider.selectedVehicleModel,
                    iconEnabledColor: Colors.black,
                    hint: TextWidget(
                      text: widget.updateVehicle ? vehicleData.vehicleModelName! : S.of(context).chooseModel,
                      fontWeight: MyFontWeight.medium,
                      textSize: MyFontSize.size12,
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
                                style: TextStyle(
                                    color: MyApp.themeMode(context)
                                        ? const Color(0xFF909090)
                                        : Colors.black,
                                    fontSize: 18)))),
                    dropdownColor: MyApp.themeMode(context)
                        ? AppColor.borderGreyLight
                        : null,
                    onChanged: (value) async {
                      packageProvider.setSelectedVehicle(value!);
                      packageProvider.chooseModel = true;
                      packageProvider.chooseRequiredModel(value: false);
                    },
                    menuMaxHeight: 25.h,
                  ),
                ),
              ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: S.of(context).nickname,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).optional,
                    textSize: MyFontSize.size12,
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
                  controller: myVehiclesProvider.nameController,
                  hintText: S.of(context).typeName,
                  fillColor: AppColor.borderGreyLight,
                  filled: true,
                  textColor: AppColor.textGrey,
                  textSize: MyFontSize.size14,
                  fontWeight: MyFontWeight.medium,
                ),
              ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: S.of(context).year,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).optional,
                    textSize: MyFontSize.size12,
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
                  controller: myVehiclesProvider.yearController,
                  hintText: S.of(context).enterYear,
                  fillColor: AppColor.borderGreyLight,
                  filled: true,
                  textColor: AppColor.textGrey,
                  textSize: MyFontSize.size14,
                  fontWeight: MyFontWeight.medium,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              verticalSpace(24),
              CustomSizedBox(
                width: double.infinity,
                child: ColorPicker(
                  // Use the screenPickerColor as start color.
                  color: myVehiclesProvider.screenPickerColor,
                  enableShadesSelection: false,
                  hasBorder: true,
                  title: TextWidget(
                    text: S.of(context).color,
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.medium,
                  ),
                  // Update the screenPickerColor using the callback.
                  onColorChanged: (Color color) {
                    setState(
                        () {
                          myVehiclesProvider.screenPickerColor = color;
                          myVehiclesProvider.vehicleColor = color.value.toString();
                        });

                        // ColorTools.nameThatColor(color);
                  },
                  borderColor: MyApp.themeMode(context) ? Colors.white : Colors.black,
                  width: 40,
                  height: 40,
                  borderRadius: 22,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  showColorName: true,
                  colorNameTextStyle: TextStyle(color: MyApp.themeMode(context) ? Colors.white : Colors.black),
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.primary : false,
                    ColorPickerType.custom : true,
                    ColorPickerType.accent : true,

                  },
                  pickerTypeLabels: <ColorPickerType, String>{
                    ColorPickerType.accent : S.of(context).accent,
                    ColorPickerType.custom : S.of(context).custom,
                  },
                  pickerTypeTextStyle: const TextStyle(color: AppColor.primary),
                  customColorSwatchesAndNames: myVehiclesProvider.customSwatches,
                ),
              ),
              verticalSpace(24),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: S.of(context).numbers,
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.medium,
                      ),
                      verticalSpace(12),
                      CustomSizedBox(
                        height: 44,
                        width: 160,
                        child: DefaultFormField(
                          controller: myVehiclesProvider.numbersController,
                          hintText: S.of(context).typeNumbers,
                          fillColor: AppColor.borderGreyLight,
                          filled: true,
                          textColor: AppColor.textGrey,
                          textSize: MyFontSize.size12,
                          fontWeight: MyFontWeight.medium,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4)
                          ],
                          onChanged: (v){
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  horizontalSpace(25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: S.of(context).letters,
                        textSize: MyFontSize.size18,
                        fontWeight: MyFontWeight.medium,
                      ),
                      verticalSpace(12),
                      CustomSizedBox(
                        height: 44,
                        width: 160,
                        child: DefaultFormField(
                          controller: myVehiclesProvider.lettersController,
                          hintText: S.of(context).typeLetters,
                          fillColor: AppColor.borderGreyLight,
                          filled: true,
                          textColor: AppColor.textGrey,
                          textSize: MyFontSize.size12,
                          fontWeight: MyFontWeight.medium,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4)
                          ],
                          onChanged: (v){
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(32),
              Align(
                alignment: Alignment.center,
                child: CustomSizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Table(
                              // textDirection: TextDirection.rtl,
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              border: TableBorder.all(
                                  width: 2, color: Colors.black),
                              children: List.generate(
                                2,
                                    (index) => TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextWidget(
                                      text: myVehiclesProvider.numbersController.text,
                                      textScaleFactor: 2.4,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      textSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextWidget(
                                      text: myVehiclesProvider.lettersController.text,
                                      textScaleFactor: 2.4,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      textSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset('assets/images/ksa.png'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              verticalSpace(12),
              Align(
                alignment: Alignment.center,
                child: TextWidget(
                  text: S.of(context).vehicleRegistrationPlate,
                  textSize: MyFontSize.size14,
                  fontWeight: MyFontWeight.medium,
                  color: AppColor.grey,
                ),
              ),
              verticalSpace(56),
              DefaultButton(
                width: 345,
                height: 48,
                text: S.of(context).save,
                fontSize: 21,
                fontWeight: MyFontWeight.bold,
                onPressed: widget.updateVehicle
                    ? ()async {

                  AppLoader.showLoader(context);
                  await myVehiclesProvider
                      .updateVehicle(
                    vehicleId: vehicleData.id!,
                      vehicleTypeId: packageProvider.selectedManufacture == null ? vehicleData.vehicleTypeId! : packageProvider.selectedManufacture!.vehicleTypeId!,
                      subVehicleTypeId: packageProvider.selectedManufacture == null ? vehicleData.subVehicleTypeId : packageProvider.selectedManufacture!.subVehicleTypeId,
                      manufacture: packageProvider.selectedManufacture == null ? vehicleData.manufacturerId! : packageProvider.selectedManufacture!.id!,
                      model: packageProvider.selectedVehicleModel == null ? vehicleData.vehicleModelId! : packageProvider.selectedVehicleModel!.id!,
                      customerId: vehicleData.customerId!,
                      numbers:
                      myVehiclesProvider.numbersController.text,
                      letters:
                      myVehiclesProvider.lettersController.text,
                      color: myVehiclesProvider.vehicleColor,
                      name: myVehiclesProvider.nameController?.text,
                      year: myVehiclesProvider.yearController.text,
                  ).then((value) {
                    // log(myVehiclesProvider.nameController.text);
                    log(myVehiclesProvider.screenPickerColor.toString());
                  AppLoader.stopLoader();
                  myVehiclesProvider.resetFields();
                  navigateAndFinish(context, const HomeScreen());
                  });
                }
                    : () async {
                  packageProvider.chooseManufacture
                      ? packageProvider.chooseModel
                          ? {
                              AppLoader.showLoader(context),
                              packageProvider.clearBorder(),
                              await myVehiclesProvider
                                  .addNewVehicle(
                                vehicleTypeId: packageProvider.selectedManufacture!.vehicleTypeId!,
                                manufacture:
                                    packageProvider.selectedManufacture!.id!,
                                model:
                                    packageProvider.selectedVehicleModel!.id!,
                                numbers:
                                    myVehiclesProvider.numbersController.text,
                                letters:
                                    myVehiclesProvider.lettersController.text,
                                color: myVehiclesProvider.vehicleColor,
                                name: myVehiclesProvider.nameController == null? packageProvider.selectedVehicleModel!.name! : myVehiclesProvider.nameController!.text == '' ? packageProvider.selectedVehicleModel!.name! : myVehiclesProvider.nameController!.text,
                                year: myVehiclesProvider.yearController.text,
                              )
                                  .then((value) {
                                AppLoader.stopLoader();
                                myVehiclesProvider.resetFields();
                                navigateAndFinish(context, const HomeScreen());
                              })
                            }
                          : packageProvider.chooseRequiredModel(value: true)
                      : packageProvider.chooseRequiredManufacture(value: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
