import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/myVehicles_provider.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import '../widgets/no_data_place_holder.dart';
import 'new_vehicle.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final MyVehiclesProvider myVehiclesProvider =
        Provider.of<MyVehiclesProvider>(context, listen: false);
    await myVehiclesProvider.getMyVehicles();
  }

  @override
  Widget build(BuildContext context) {
    final MyVehiclesProvider myVehiclesProvider =
        Provider.of<MyVehiclesProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Vehicles',
      ),
      /*
      *  myVehiclesProvider.loadingMyVehicles
                    ? const DataLoader(useExpand: true)
                    : myVehiclesProvider.myVehiclesData == null
                        ? const NoDataPlaceHolder()
                        : */
      body: myVehiclesProvider.loadingMyVehicles
          ? const DataLoader()
          : Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: Column(
                children: [
                  myVehiclesProvider.myVehiclesData!.total == 0
                      ? const NoDataPlaceHolder()
                      : MyVehiclesScreenWidget(
                          myVehiclesProvider: myVehiclesProvider),
                  DefaultButton(
                    text: 'Add new Vehicle',
                    onPressed: () {
                      navigateTo(context, const VehicleInfo());
                    },
                    fontWeight: MyFontWeight.bold,
                    fontSize: 21,
                    height: 48,
                    width: 345,
                  ),
                  verticalSpace(50)
                ],
              ),
            ),
    );
  }
}

class MyVehiclesScreenWidget extends StatelessWidget {
  const MyVehiclesScreenWidget({
    super.key,
    required this.myVehiclesProvider,
  });

  final MyVehiclesProvider myVehiclesProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: symmetricEdgeInsets(vertical: 30),
        child: ListView.separated(
          itemCount: myVehiclesProvider.myVehiclesData!.collection!.length,
          itemBuilder: (context, index) => CustomContainer(
            height: 64,
            width: 345,
            backgroundColor: AppColor.borderGreyLight,
            child: Padding(
              padding: symmetricEdgeInsets(vertical: 7, horizontal: 7),
              child: Row(
                children: [
                  CustomContainer(
                    width: 71,
                    height: 50,
                    radiusCircular: 3,
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    backgroundColor: Colors.transparent,
                    child: Image.network(
                      myVehiclesProvider
                          .myVehiclesData!.collection![index].manufacturerLogo!,
                      fit: BoxFit.fitHeight,
                      width: 71,
                      height: 50,
                    ),
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: Padding(
                      padding: onlyEdgeInsets(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text:
                                '${myVehiclesProvider.myVehiclesData!.collection![index].manufacturerName}, ${myVehiclesProvider.myVehiclesData!.collection![index].vehicleModelName} /${myVehiclesProvider.myVehiclesData!.collection![index].name} ${myVehiclesProvider.myVehiclesData!.collection![index].year} (${myVehiclesProvider.myVehiclesData!.collection![index].numbers} ${myVehiclesProvider.myVehiclesData!.collection![index].letters})',
                            maxLines: 2,
                            fontWeight: MyFontWeight.semiBold,
                            textSize: MyFontSize.size10,
                          ),
                          verticalSpace(9),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 6,
                                backgroundColor: Color(0xFF3424F1),
                              ),
                              horizontalSpace(6),
                              TextWidget(
                                text:
                                    '${myVehiclesProvider.myVehiclesData!.collection![index].color} ,${myVehiclesProvider.myVehiclesData!.collection![index].vehicleTypeName} (${myVehiclesProvider.myVehiclesData!.collection![index].numbers} ${myVehiclesProvider.myVehiclesData!.collection![index].letters})',
                                fontWeight: MyFontWeight.medium,
                                textSize: MyFontSize.size10,
                                maxLines: 1,
                                color: AppColor.textGrey,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => verticalSpace(14),
        ),
        /*child: Column(
    children: [
      CustomContainer(
        height: 64,
        width: 345,
        backgroundColor: AppColor.borderGrey,
        child: Padding(
          padding:
          symmetricEdgeInsets(vertical: 7, horizontal: 7),
          child: Row(
            children: [
              CustomContainer(
                width: 71,
                height: 50,
                radiusCircular: 3,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/mazda.png',
                  fit: BoxFit.fitHeight,
                  width: 71,
                  height: 50,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Padding(
                  padding: onlyEdgeInsets(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text:
                        'Mazda, Cx3 2020 /Tarut 32626 (WRQA 1514)',
                        maxLines: 2,
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size10,
                      ),
                      verticalSpace(9),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 6,
                            backgroundColor: Color(0xFF3424F1),
                          ),
                          horizontalSpace(6),
                          TextWidget(
                            text: 'Blue ,Small car (WRQA 1514)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            maxLines: 1,
                            color: AppColor.textGrey,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      verticalSpace(14),
      CustomContainer(
        height: 64,
        width: 345,
        backgroundColor: AppColor.borderGrey,
        child: Padding(
          padding:
          symmetricEdgeInsets(vertical: 7, horizontal: 7),
          child: Row(
            children: [
              CustomContainer(
                width: 71,
                height: 50,
                radiusCircular: 3,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/mazda.png',
                  fit: BoxFit.fitHeight,
                  width: 71,
                  height: 50,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Padding(
                  padding: onlyEdgeInsets(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text:
                        'Mazda, Cx3 2020 /Tarut 32626 (WRQA 1514)',
                        maxLines: 2,
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size10,
                      ),
                      verticalSpace(9),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 6,
                            backgroundColor: Color(0xFFF12424),
                          ),
                          horizontalSpace(6),
                          TextWidget(
                            text: 'Blue ,Small car (WRQA 1514)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            maxLines: 1,
                            color: AppColor.textGrey,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      verticalSpace(14),
      CustomContainer(
        height: 64,
        width: 345,
        backgroundColor: AppColor.borderGrey,
        child: Padding(
          padding:
          symmetricEdgeInsets(vertical: 7, horizontal: 7),
          child: Row(
            children: [
              CustomContainer(
                width: 71,
                height: 50,
                radiusCircular: 3,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/mazda.png',
                  fit: BoxFit.fitHeight,
                  width: 71,
                  height: 50,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Padding(
                  padding: onlyEdgeInsets(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text:
                        'Mazda, Cx3 2020 /Tarut 32626 (WRQA 1514)',
                        maxLines: 2,
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size10,
                      ),
                      verticalSpace(9),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 6,
                            backgroundColor: Color(0xFF000000),
                          ),
                          horizontalSpace(6),
                          TextWidget(
                            text: 'Blue ,Small car (WRQA 1514)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            maxLines: 1,
                            color: AppColor.textGrey,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      verticalSpace(14),
      CustomContainer(
        height: 64,
        width: 345,
        backgroundColor: AppColor.borderGrey,
        child: Padding(
          padding:
          symmetricEdgeInsets(vertical: 7, horizontal: 7),
          child: Row(
            children: [
              CustomContainer(
                width: 71,
                height: 50,
                radiusCircular: 3,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/mazda.png',
                  fit: BoxFit.fitHeight,
                  width: 71,
                  height: 50,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Padding(
                  padding: onlyEdgeInsets(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text:
                        'Mazda, Cx3 2020 /Tarut 32626 (WRQA 1514)',
                        maxLines: 2,
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size10,
                      ),
                      verticalSpace(9),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 6,
                            backgroundColor: Color(0xFF7C7A89),
                          ),
                          horizontalSpace(6),
                          TextWidget(
                            text: 'Blue ,Small car (WRQA 1514)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            maxLines: 1,
                            color: AppColor.textGrey,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
                ),*/
      ),
    );
  }
}
