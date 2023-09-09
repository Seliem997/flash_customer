import 'package:flash_customer/providers/home_provider.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../providers/addresses_provider.dart';
import '../../../utils/styles/colors.dart';
import '../../addresses/new_address.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/expanded_container.dart';
import '../../widgets/text_widget.dart';

class SavedLocationExpanded extends StatefulWidget {
  const SavedLocationExpanded({Key? key}) : super(key: key);

  @override
  State<SavedLocationExpanded> createState() => _SavedLocationExpandedState();
}

class _SavedLocationExpandedState extends State<SavedLocationExpanded> {
  bool expandLocationFlag = false;

  @override
  Widget build(BuildContext context) {
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: ExpandableContainer(
            expanded: expandLocationFlag,
            expandedHeight: 27.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: Column(
                children: [
                  addressesProvider.addressesDataList.isEmpty
                      ? const Expanded(
                          child: Center(
                              child: TextWidget(
                          text: 'There is No Addresses Yet',
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          textSize: 20,
                                height: 1.4,
                        )))
                      : Expanded(
                          child: ListView.separated(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              DefaultButtonWithIcon(
                            width: 187,
                            height: 34,
                            padding: symmetricEdgeInsets(horizontal: 28),
                            borderRadius: BorderRadius.circular(8),
                            backgroundButton: AppColor.white,
                            icon: CustomSizedBox(
                              height: 20,
                              width: 20,
                              child: addressesProvider
                                          .addressesDataList[index].type! ==
                                      "home"
                                  ? Image.asset('assets/images/home_light.png')
                                  : addressesProvider
                                              .addressesDataList[index].type! ==
                                          "work"
                                      ? SvgPicture.asset(
                                          'assets/svg/work.svg',color: MyApp.themeMode(context) ? Colors.white : Colors.black,
                                        )
                                      : addressesProvider
                                                  .addressesDataList[index]
                                                  .type! ==
                                              "work"
                                          ? SvgPicture.asset(
                                              'assets/svg/school.svg',color: MyApp.themeMode(context) ? Colors.white : Colors.black,
                                            )
                                          : Image.network(addressesProvider
                                              .addressesDataList[index].image!),
                            ),
                            onPressed: () {
                              setState(() {
                                expandLocationFlag = !expandLocationFlag;
                              });
                              homeProvider.mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      zoom: 13.5,
                                      target: LatLng(
                                          double.parse(addressesProvider
                                              .addressesDataList[index]
                                              .latitude),
                                          double.parse(addressesProvider
                                              .addressesDataList[index]
                                              .langitude)))));

                               homeProvider.currentPosition = Position(
                                 latitude: double.parse(addressesProvider.addressesDataList[index].latitude),
                                 longitude: double.parse(addressesProvider.addressesDataList[index].langitude),
                                 timestamp: homeProvider.currentPosition!.timestamp,
                                 accuracy: homeProvider.currentPosition!.accuracy,
                                 altitude: homeProvider.currentPosition!.altitude,
                                 heading: homeProvider.currentPosition!.heading,
                                 speed: homeProvider.currentPosition!.speed,
                                 speedAccuracy: homeProvider.currentPosition!.speedAccuracy,
                               );

                              homeProvider.markers.clear();
                              homeProvider.resetMap();
                              Marker marker = Marker(
                                markerId: const MarkerId("Saved_Location"),
                                draggable: true,
                                position: LatLng(double.parse(addressesProvider.addressesDataList[index].latitude),
                                    double.parse(addressesProvider.addressesDataList[index].langitude)),
                                icon: BitmapDescriptor.defaultMarker,
                              );
                              homeProvider.markers.add(marker);

                            },
                            labelText: addressesProvider
                                .addressesDataList[index]
                                .locationName ??
                                '${addressesProvider.addressesDataList[index].type!}${S.of(context).location}',
                            textColor: AppColor.black,
                          ),
                          separatorBuilder: (context, index) =>
                              verticalSpace(4),
                          itemCount: addressesProvider.addressesDataList.length,
                        )),
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                          context,
                          const NewAddress(
                            cameFromHomeScreen: true,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.primary),
                      child: const Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomContainer(
          onTap: () {
            setState(() {
              expandLocationFlag = !expandLocationFlag;
            });
          },
          width: 219,
          height: 38,
          padding: symmetricEdgeInsets(horizontal: 30),
          backgroundColor: AppColor.primary,
          backgroundColorDark: AppColor.dark,
          child: Row(
            children: <Widget>[
              TextWidget(
                text: S.of(context).savedLocation,
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
                color: AppColor.white,
              ),
              const Spacer(),
              Container(
                height: 18.0,
                width: 18.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 1, color: AppColor.white),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    expandLocationFlag
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
