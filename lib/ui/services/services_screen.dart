import 'package:flash_customer/ui/services/widgets/services_widgets.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/addresses_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/styles/colors.dart';
import '../date_time/select_date.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen(
      {Key? key, required this.cityId, required this.vehicleId})
      : super(key: key);
  final int cityId;
  final int vehicleId;

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestServicesProvider servicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);

    await servicesProvider.getBasicServices(
      cityId: widget.cityId,
      vehicleId: widget.vehicleId,
    );
    await servicesProvider.getExtraServices(
      cityId: widget.cityId,
      vehicleId: widget.vehicleId,
    );
    // await servicesProvider.getTax();
    servicesProvider.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).services),
      body: SingleChildScrollView(
        child: (requestServicesProvider
                .isLoading /*||
                requestServicesProvider.taxData == null*/
            )
            ? const DataLoader()
            : (requestServicesProvider.basicServicesList.isEmpty ||
                    requestServicesProvider.extraServicesList.isEmpty)
                ? CustomSizedBox(
                    height: 500,
                    child: Center(
                        child: TextWidget(
                            text: S.of(context).noServicesAvailable)))
                : Padding(
                    padding: symmetricEdgeInsets(horizontal: 24, vertical: 41),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: S.of(context).basicServices,
                          textSize: MyFontSize.size16,
                          fontWeight: MyFontWeight.semiBold,
                          color: const Color(0xFF4B4B4B),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          width: double.infinity,
                          radiusCircular: 4,
                          backgroundColor: const Color(0xFFF9F9F9),
                          child: Padding(
                            padding: onlyEdgeInsets(
                              start: 11,
                              end: 21,
                              bottom: 22,
                              top: 22,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  BasicServicesWidget(
                                title: requestServicesProvider
                                    .basicServicesList[index].title!,
                                imageName: requestServicesProvider
                                    .basicServicesList[index].image!,
                                onTap: () {
                                  requestServicesProvider.selectedBasicService(
                                      index: index);
                                  requestServicesProvider.calculateTotal();
                                  requestServicesProvider
                                          .selectedBasicServiceId =
                                      requestServicesProvider
                                          .basicServicesList[index].id!;
                                },
                                index: index,
                                infoOnPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextWidget(
                                            text:
                                                '${requestServicesProvider.basicServicesList[index].info}',
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
                                                  text: S.of(context).cancel,
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
                              ),
                              separatorBuilder: (context, index) =>
                                  verticalSpace(14),
                              itemCount: requestServicesProvider
                                  .basicServicesList.length,
                            ),
                          ),
                        ),
                        verticalSpace(40),
                        TextWidget(
                          text: S.of(context).extraServices,
                          textSize: MyFontSize.size16,
                          fontWeight: MyFontWeight.semiBold,
                          color: const Color(0xFF4B4B4B),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          width: double.infinity,
                          radiusCircular: 4,
                          backgroundColor: const Color(0xFFF9F9F9),
                          child: requestServicesProvider
                                  .extraServicesList.isEmpty
                              ? const DataLoader()
                              : Padding(
                                  padding: onlyEdgeInsets(
                                    start: 11,
                                    end: 21,
                                    bottom: 22,
                                    top: 22,
                                  ),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        ExtraServicesWidget(
                                      extraService: requestServicesProvider
                                          .extraServicesList[index],
                                      infoOnPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: TextWidget(
                                                  text:
                                                      '${requestServicesProvider.extraServicesList[index].info}',
                                                ),
                                              ),
                                              actions: [
                                                Padding(
                                                  padding: symmetricEdgeInsets(
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      DefaultButton(
                                                        width: 130,
                                                        height: 30,
                                                        text: S
                                                            .of(context)
                                                            .cancel,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
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
                                    ),
                                    separatorBuilder: (context, index) =>
                                        verticalSpace(14),
                                    itemCount: requestServicesProvider
                                        .extraServicesList.length,
                                  ),
                                  /*child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFE1ECFF),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                              ),
                              CustomSizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Image.asset(
                                      'assets/images/chair_image.png')),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'One chair Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: Row(
                                  children: [
                                    CustomSizedBox(
                                      width: 18,
                                      height: 23,
                                      child: Image.asset(
                                          'assets/images/minus.png'),
                                    ),
                                    horizontalSpace(9),
                                    TextWidget(
                                      text: '1',
                                      fontWeight: MyFontWeight.bold,
                                      textSize: MyFontSize.size12,
                                    ),
                                    horizontalSpace(9),
                                    CustomSizedBox(
                                      width: 18,
                                      height: 23,
                                      child:
                                          Image.asset('assets/images/plus.png'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFD1D1D1),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                                // child: Icon(Icons.info, size: 20, color: AppColor.primary),
                              ),
                              CustomSizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/extraServices_image.png'),
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'All chair Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.dark,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: const CustomContainer(
                                  radiusCircular: 5,
                                  backgroundColor: Colors.transparent,
                                  height: 19,
                                  width: 20,
                                  borderColor: AppColor.subTextGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFD1D1D1),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                                // child: Icon(Icons.info, size: 20, color: AppColor.primary),
                              ),
                              CustomSizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/basicServices_image.png'),
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'Inside Only Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.dark,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: const CustomContainer(
                                  radiusCircular: 5,
                                  backgroundColor: Colors.transparent,
                                  height: 19,
                                  width: 20,
                                  borderColor: AppColor.subTextGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFD1D1D1),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                                // child: Icon(Icons.info, size: 20, color: AppColor.primary),
                              ),
                              CustomSizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/basicServices_image.png'),
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'Inside Only Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.dark,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: const CustomContainer(
                                  radiusCircular: 5,
                                  backgroundColor: Colors.transparent,
                                  height: 19,
                                  width: 20,
                                  borderColor: AppColor.subTextGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                                ),
                        ),
                        verticalSpace(25),
                        Row(
                          children: [
                            CustomSizedBox(
                                height: 18,
                                width: 18,
                                child: Image.asset('assets/images/clock.png')),
                            horizontalSpace(4),
                            TextWidget(
                              text: S.of(context).serviceDuration,
                              textSize: MyFontSize.size15,
                              fontWeight: MyFontWeight.bold,
                            ),
                            TextWidget(
                              text:
                                  ' ${(requestServicesProvider.totalDuration)} ${S.of(context).min}',
                              textSize: MyFontSize.size15,
                              fontWeight: MyFontWeight.medium,
                              color: const Color(0xFF686868),
                            ),
                          ],
                        ),
                        verticalSpace(25),
                        CustomContainer(
                          width: 345,
                          borderColor: AppColor.primary,
                          backgroundColor: const Color(0xFFF1F6FE),
                          child: Padding(
                            padding: symmetricEdgeInsets(
                                vertical: 24, horizontal: 24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      text: S.of(context).amount,
                                      textSize: MyFontSize.size15,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text:
                                          '${requestServicesProvider.totalAmount} ${S.of(context).sr}',
                                      // text: '${requestServicesProvider.basicAmount + requestServicesProvider.extraAmount} SR',
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF383838),
                                    ),
                                  ],
                                ),
                                verticalSpace(20),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: S.of(context).tax,
                                      textSize: MyFontSize.size15,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text:
                                          '${requestServicesProvider.totalTaxes} ${S.of(context).sr}',
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF383838),
                                    ),
                                  ],
                                ),
                                verticalSpace(20),
                                /*Row(
                                  children: [
                                    TextWidget(
                                      text: 'Discount code : ',
                                      textSize: MyFontSize.size14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    CustomContainer(
                                      width: 112,
                                      height: 30,
                                      radiusCircular: 3,
                                      backgroundColor: AppColor.buttonGrey,
                                      borderColor: AppColor.boldGrey,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: DefaultFormField(
                                          controller: requestServicesProvider
                                              .discountCodeController,
                                          withBorder: false,
                                          // padding: 10,
                                          // contentPadding: onlyEdgeInsets(start: 10),
                                          textInputAction: TextInputAction.done,
                                          hintText: '',
                                          enabled: requestServicesProvider
                                                  .couponData ==
                                              null,
                                          padding: symmetricEdgeInsets(
                                              vertical: 9, horizontal: 5),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: requestServicesProvider
                                                  .couponData !=
                                              null
                                          ? () {
                                              requestServicesProvider
                                                  .resetCoupon();
                                            }
                                          : () {
                                              requestServicesProvider
                                                  .checkOfferCoupon(context);
                                            },
                                      child: TextWidget(
                                        text: requestServicesProvider
                                                    .couponData !=
                                                null
                                            ? S.of(context).remove
                                            : S.of(context).apply,
                                        textSize: MyFontSize.size12,
                                        fontWeight: MyFontWeight.medium,
                                        color: requestServicesProvider
                                                    .couponData !=
                                                null
                                            ? AppColor.textRed
                                            : AppColor.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(15),*/
                                const Divider(
                                  color: AppColor.borderGrey,
                                  thickness: 1.5,
                                ),
                                verticalSpace(15),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Total Amount :',
                                      textSize: MyFontSize.size15,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text:
                                          '${(requestServicesProvider.totalAmount + requestServicesProvider.totalTaxes)} ${S.of(context).sr}',
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF383838),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(64),
                        DefaultButton(
                          width: 345,
                          height: 48,
                          text: S.of(context).book,
                          fontSize: 21,
                          fontWeight: MyFontWeight.bold,
                          onPressed: () {
                            if (requestServicesProvider.selectedBasicIndex !=
                                null) {
                              AppLoader.showLoader(context);
                              requestServicesProvider
                                  .bookServices(
                                context,
                                cityId: widget.cityId,
                                vehicleId: widget.vehicleId,
                                basicServiceId: requestServicesProvider
                                    .selectedBasicServiceId,
                                addressId:
                                    addressesProvider.addressDetailsData!.id!,
                              )
                                  .then((value) {
                                AppLoader.stopLoader();
                                if (value.status == Status.success) {
                                  navigateTo(context, const SelectDate());
                                } else {
                                  CustomSnackBars.failureSnackBar(
                                      context, '${value.message}');
                                }
                              });
                            } else {
                              CustomSnackBars.failureSnackBar(context,
                                  S.of(context).pleaseSelectBasicService);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
