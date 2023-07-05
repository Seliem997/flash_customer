import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flash_customer/ui/vehicles/vehicles_type.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
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
        title: S.of(context).myVehicles,
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
                    text: S.of(context).addNewVehicle,
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
          itemBuilder: (context, index) => Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  flex: 1,
                  onPressed: (BuildContext context) {
                    myVehiclesProvider.deleteVehicle(
                        vehicleID: myVehiclesProvider
                            .myVehiclesData!.collection![index].id!);
                  },
                  backgroundColor: const Color(0xFFE74A2A),
                  foregroundColor: Colors.white,
                  icon: Icons.delete_forever_outlined,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (BuildContext context) {
                    navigateTo(context, VehicleInfo(updateVehicle: true,index: index,));
                  },
                  backgroundColor: const Color(0xFF28A72D),
                  foregroundColor: Colors.white,
                  icon: Icons.mode_edit_outline_outlined,
                  label: S.of(context).edit,
                ),
              ],
            ),
            child: CustomContainer(
              height: 70,
              width: 345,
              borderColor: myVehiclesProvider.selectedMyVehicleIndex == index
                  ? AppColor.borderBlue
                  : Colors.transparent,
              borderColorDark:
                  myVehiclesProvider.selectedMyVehicleIndex == index
                      ? AppColor.borderBlue
                      : null,
              backgroundColor:
                  myVehiclesProvider.selectedMyVehicleIndex == index
                      ? const Color(0xFFE6EEFB)
                      : AppColor.borderGreyLight,
              onTap: () {
                myVehiclesProvider.setSelectedMyVehicle(index: index);
              },
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
                      borderColorDark: Colors.transparent,
                      child: FastCachedImage(
                        url: myVehiclesProvider.myVehiclesData!
                            .collection![index].manufacturerLogo!,
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
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: myVehiclesProvider.myVehiclesData!.collection![index].color == null ? Colors.white : Color(int.parse(myVehiclesProvider.myVehiclesData!.collection![index].color!)),
                                ),
                                horizontalSpace(6),
                                TextWidget(
                                  text:
                                      '${myVehiclesProvider.myVehiclesData!.collection![index].color == null ? Colors.white : ColorTools.nameThatColor(Color(int.parse(myVehiclesProvider.myVehiclesData!.collection![index].color!)))} ,${myVehiclesProvider.myVehiclesData!.collection![index].vehicleTypeName} (${myVehiclesProvider.myVehiclesData!.collection![index].numbers} ${myVehiclesProvider.myVehiclesData!.collection![index].letters})',
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
          ),
          separatorBuilder: (context, index) => verticalSpace(14),
        ),
      ),
    );
  }
}
