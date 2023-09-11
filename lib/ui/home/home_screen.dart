import 'dart:developer';

import 'package:flash_customer/main.dart';
import 'package:flash_customer/providers/home_provider.dart';
import 'package:flash_customer/providers/user_provider.dart';
import 'package:flash_customer/ui/home/widgets/widgets.dart';
import 'package:flash_customer/ui/requests/myRequests.dart';
import 'package:flash_customer/ui/user/register/register.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/addresses_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/cache_helper.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../payment/test.dart';
import '../services/other_services_screen.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../vehicles/vehicles_type.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.cameFromNewRequest = false})
      : super(key: key);

  final bool cameFromNewRequest;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0, 0));
  final bool loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  String? _darkMapStyle;
  String? _lightMapStyle;

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_styles/light.json');
    _setMapStyle();
  }

  Future _setMapStyle() async {
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    if (MyApp.themeMode(context)) {
      homeProvider.mapController.setMapStyle(_darkMapStyle);
      setState(() {});
    } else {
      // homeProvider.mapController.setMapStyle(_lightMapStyle);
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    if (widget.cameFromNewRequest) {
      navigateTo(context, const MyRequests());
    } else {
      final AddressesProvider addressesProvider =
          Provider.of<AddressesProvider>(context, listen: false);
      _loadMapStyles();
      final HomeProvider homeProvider =
          Provider.of<HomeProvider>(context, listen: false);
      homeProvider.markers.clear();
      await _handleLocationPermission();
      await _getCurrentLocation();
      loggedIn ? addressesProvider.getAddresses() : null;
    }
  }

  _getCurrentLocation() async {
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.markers.clear();
    homeProvider.resetMap();
    try {
      AppLoader.showLoader(context);
      await Geolocator.getCurrentPosition().then((Position position) async {
        AppLoader.stopLoader();
        // print("Cur Position1: ${position.longitude} ${position.latitude}");
        homeProvider.currentPosition = position;
        homeProvider.startMarker();
        homeProvider.mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.5,
            ),
          ),
        );
      }).catchError((e) {
        log("Error in accessing current location $e");
      });
    } catch (e) {
      log("Error in accessing current location $e");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S
              .of(context)
              .locationServicesAreDisabledPleaseEnableTheServices)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).locationPermissionsAreDenied)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S
              .of(context)
              .locationPermissionsArePermanentlyDeniedWeCannotRequestPermissions)));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);

    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.from(homeProvider.markers),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: Set<Polyline>.of(homeProvider.polylines.values),
            onLongPress: (latlang) {
              homeProvider.markers.clear();
              homeProvider.resetMap();
              homeProvider.addMarkerLongPressed(
                  latlang); //we will call this function when pressed on the map
            },
            onMapCreated: (GoogleMapController controller) {
              homeProvider.mapController = controller;
            },
          ),
          Column(
            children: [
              Padding(
                padding: onlyEdgeInsets(top: 68, start: 24, end: 24),
                child: buildHeader(
                    context: context,
                    onTap: () {
                      globalKey.currentState!.openDrawer();
                    }),
              ),
              verticalSpace(15),
              Visibility(
                visible: loggedIn,
                child: const SavedLocationExpanded(),
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      homeProvider.mapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              zoom: 18.5,
                              target: LatLng(
                                  homeProvider.currentPosition!.latitude,
                                  homeProvider.currentPosition!.longitude))));
                    },
                    child: Padding(
                      padding: onlyEdgeInsets(end: 24),
                      child: CustomSizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/images/locationSpot.png'),
                      ),
                    ),
                  )),
              verticalSpace(32),
              DefaultButton(
                width: 294,
                height: 56,
                backgroundColor:
                    MyApp.themeMode(context) ? AppColor.dark : AppColor.primary,
                text: S.of(context).wash,
                fontSize: 28,
                fontWeight: MyFontWeight.bold,
                onPressed: loggedIn
                    ? () async {
                        AppLoader.showLoader(context);
                        await addressesProvider
                            .storeAddress(
                          lat: homeProvider.currentPosition!.latitude,
                          long: homeProvider.currentPosition!.longitude,
                        )
                            .then((value) {
                          AppLoader.stopLoader();
                          if (value.status == Status.success) {
                            navigateTo(context, const VehicleTypes());
                          } else {
                            CustomSnackBars.failureSnackBar(
                                context, '${value.message}');
                          }
                        });
                      }
                    : () {
                  userProvider.statusType = 'wash service';
                  navigateTo(context, const RegisterPhoneNumber());
                      },
              ),
              verticalSpace(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButton(
                    width: 140,
                    height: 45,
                    backgroundColor: MyApp.themeMode(context)
                        ? AppColor.dark
                        : AppColor.buttonGrey,
                    text: S.of(context).products,
                    textColor: AppColor.black,
                    onPressed: () {
                      homeProvider.launchExpectedURL(
                          expectedUrl: 'https://flashwashstore.com/');
                    },
                    fontWeight: MyFontWeight.medium,
                    fontSize: MyFontSize.size14,
                  ),
                  horizontalSpace(12),
                  DefaultButton(
                    width: 140,
                    height: 45,
                    backgroundColor: MyApp.themeMode(context)
                        ? AppColor.dark
                        : AppColor.buttonGrey,
                    text: S.of(context).otherServices,
                    textColor: AppColor.black,
                    onPressed: loggedIn
                        ? () async {
                            AppLoader.showLoader(context);
                            await addressesProvider
                                .storeAddress(
                              lat: homeProvider.currentPosition!.latitude,
                              long: homeProvider.currentPosition!.longitude,
                            )
                                .then((value) {
                              if (value.status == Status.success) {
                                AppLoader.stopLoader();
                                navigateTo(
                                  context,
                                  const OtherServices(),
                                );
                              } else {
                                CustomSnackBars.failureSnackBar(
                                    context, '${value.message}');
                                AppLoader.stopLoader();
                              }
                            });
                          }
                        : () {
                      userProvider.statusType = 'other service';
                      navigateTo(context, const RegisterPhoneNumber());
                          },
                    fontWeight: MyFontWeight.medium,
                    fontSize: MyFontSize.size14,
                  ),
                ],
              ),
              verticalSpace(14),
            ],
          ),
        ],
      ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }

  Future<dynamic> buildLoginDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextWidget(
              text: S.of(context).pleaseLogInFirst,
            ),
          ),
          actions: [
            Padding(
              padding: symmetricEdgeInsets(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButton(
                    width: 90,
                    height: 30,
                    text: S.of(context).cancel,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColor.lightRed,
                  ),
                  horizontalSpace(20),
                  DefaultButton(
                    width: 100,
                    height: 30,
                    text: S.of(context).logIn,
                    onPressed: () {
                      Navigator.pop(context);
                      navigateTo(context, const RegisterPhoneNumber());
                    },
                    backgroundColor: AppColor.primary,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Row buildHeader({required BuildContext context, onTap}) {
    final bool loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
    return loggedIn
        ? Row(
            children: [
              CustomSizedBox(
                width: 24,
                height: 24,
                onTap: onTap,
                child: SvgPicture.asset(
                  'assets/svg/menu.svg',
                  color: MyApp.themeMode(context) ? Colors.white : Colors.black,
                ),
              ),
              horizontalSpace(122),
              CustomSizedBox(
                  width: 67,
                  height: 64,
                  child: Image.asset('assets/images/logo.png'))
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSizedBox(
                  width: 67,
                  height: 64,
                  child: Image.asset('assets/images/logo.png')),
            ],
          );
  }
}
