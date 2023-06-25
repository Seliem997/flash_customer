import 'package:flash_customer/ui/services/waxing_services/waxing_services.dart';
import 'package:flash_customer/ui/services/widgets/other_services_widgets.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/addresses_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/otherServices_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/font_styles.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../date_time/select_date.dart';
import '../home/home_screen.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';
import '../widgets/text_widget.dart';

class OtherServices extends StatefulWidget {
  const OtherServices({Key? key}) : super(key: key);

  @override
  State<OtherServices> createState() => _OtherServicesState();
}

class _OtherServicesState extends State<OtherServices> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final OtherServicesProvider otherServicesProvider =
        Provider.of<OtherServicesProvider>(context, listen: false);
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    otherServicesProvider.setLoading(true);
    await requestServicesProvider
        .getCityId(
          lat: homeProvider.currentPosition!.latitude,
          long: homeProvider.currentPosition!.longitude,
        )
        .then((value) => otherServicesProvider.getOtherServices(
            cityId: requestServicesProvider.cityIdData!.id!));
  }

  @override
  Widget build(BuildContext context) {
    final OtherServicesProvider otherServicesProvider =
        Provider.of<OtherServicesProvider>(context);
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Other Services',
        onTap: () {
          navigateAndFinish(context, const HomeScreen());
          otherServicesProvider.clearServices();
        },
      ),
      body: otherServicesProvider.isLoading
          ? const DataLoader()
          : otherServicesProvider.otherServicesList.isEmpty
              ? const Expanded(
                  child:
                      Center(child: TextWidget(text: 'There are No Services')))
              : Padding(
                  padding: symmetricEdgeInsets(horizontal: 12, vertical: 40),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: onlyEdgeInsets(start: 11),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                otherServicesProvider.otherServicesList.length,
                            itemBuilder: (context, index) {
                              return OtherServicesItem(
                                title: otherServicesProvider
                                    .otherServicesList[index].title!,
                                imageName: otherServicesProvider
                                    .otherServicesList[index].image!,
                                serviceValue:
                                    '${otherServicesProvider.otherServicesList[index].selectedPrice} SR',
                                serviceUnit: otherServicesProvider
                                    .otherServicesList[index].costType,
                                onlyValue: otherServicesProvider
                                            .otherServicesList[index]
                                            .costType ==
                                        "pricable"
                                    ? true
                                    : false,
                                infoOnPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextWidget(
                                            text:
                                                '${otherServicesProvider.otherServicesList[index].info}',
                                          ),
                                        ),
                                        actions: [
                                          Padding(
                                            padding: symmetricEdgeInsets(
                                                vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DefaultButton(
                                                  width: 130,
                                                  height: 30,
                                                  text: 'Cancel',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  backgroundColor:
                                                      AppColor.boldGreen,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                onTap: () {
                                  otherServicesProvider.selectedOtherServiceId =
                                      otherServicesProvider
                                          .otherServicesList[index].id!;
                                  otherServicesProvider.selectedService(
                                      index: index);
                                },
                                index: index,
                                service: otherServicesProvider
                                    .otherServicesList[index],
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 220,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: symmetricEdgeInsets(horizontal: 11),
                        child: DefaultButton(
                          height: 48,
                          width: double.infinity,
                          fontWeight: MyFontWeight.bold,
                          fontSize: MyFontSize.size20,
                          text: 'Next',
                          onPressed: () {
                            if (otherServicesProvider.selectedServiceIndex != null) {
                              if (otherServicesProvider.otherServicesList[otherServicesProvider.selectedServiceIndex!].quantity != 0) {
                                AppLoader.showLoader(context);
                                otherServicesProvider
                                    .storeInitialOtherServices(
                                  context,
                                  cityId:
                                      requestServicesProvider.cityIdData!.id!,
                                  otherServiceId: otherServicesProvider
                                      .selectedOtherServiceId,
                                  addressId:
                                      addressesProvider.addressDetailsData!.id!,
                                  numberOfUnits: otherServicesProvider
                                      .otherServicesList[otherServicesProvider
                                          .selectedServiceIndex!]
                                      .quantity,
                                )
                                    .then((value) {
                                  AppLoader.stopLoader();
                                  if (value.status == Status.success) {
                                    navigateTo(
                                        context,
                                        const SelectDate(
                                          cameFromOtherServices: true,
                                        ));
                                  } else {
                                    CustomSnackBars.failureSnackBar(
                                        context, '${value.message}');
                                  }
                                });
                              } else {
                                CustomSnackBars.failureSnackBar(
                                    context, 'increase your value first');
                              }
                            }else {
                              CustomSnackBars.failureSnackBar(
                                  context, 'Please Select Service');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
