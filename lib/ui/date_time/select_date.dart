import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flash_customer/generated/l10n.dart';
import 'package:flash_customer/providers/otherServices_provider.dart';
import 'package:flash_customer/providers/package_provider.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../../utils/font_styles.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/enum/date_formats.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/snack_bars.dart';
import '../home/home_screen.dart';
import '../payment/go_sell_payment.dart';
import '../requests/request_details.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class SelectDate extends StatefulWidget {
  const SelectDate(
      {Key? key,
      this.cameFromOtherServices = false,
      this.cameFromPackage = false,
      this.index})
      : super(key: key);

  final bool cameFromOtherServices;
  final bool cameFromPackage;
  final int? index;
  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);

    final OtherServicesProvider otherServicesProvider =
        Provider.of<OtherServicesProvider>(context, listen: false);

    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context, listen: false);

    requestServicesProvider.selectedSlotIndex = null;
    otherServicesProvider.selectedTimeSlot();
    packageProvider.selectedSlotIndex = null;

    widget.cameFromPackage
        ? packageProvider.washesDate[widget.index] =
        DateFormat(DFormat.ymd.key).format(DateTime.now())
        : widget.cameFromOtherServices
        ? otherServicesProvider.selectedDate =
        DateFormat(DFormat.ymd.key).format(DateTime.now())
        : requestServicesProvider.selectedDate =
        DateFormat(DFormat.ymd.key).format(DateTime.now());

    widget.cameFromPackage
        ? await packageProvider.getPackageTimeSlots(
            cityId: requestServicesProvider.cityIdData!.id!,
            packageId: packageProvider
                .packagesDataList[packageProvider.selectedPackageIndex!].id!,
            packageDuration: packageProvider
                .packagesDataList[packageProvider.selectedPackageIndex!]
                .duration!,
            date: DateFormat(DFormat.mdy.key)
                .format(requestServicesProvider.date),
          )
        : widget.cameFromOtherServices
            ? await otherServicesProvider
                .getOtherServicesSlots(
                  cityId: requestServicesProvider.cityIdData!.id!,
                  serviceId: otherServicesProvider.selectedOtherServiceId,
                  duration: otherServicesProvider
                      .otherServicesList[
                          otherServicesProvider.selectedServiceIndex!]
                      .duration!
                      .toDouble(),
                  date: DateFormat(DFormat.mdy.key)
                      .format(requestServicesProvider.date),
                )
                .then((value) => requestServicesProvider.setLoading(false))
            : await requestServicesProvider
                .getTimeSlots(
                  cityId: requestServicesProvider.cityIdData!.id!,
                  basicId: requestServicesProvider.selectedBasicServiceId,
                  duration: requestServicesProvider.totalDuration,
                  date: DateFormat(DFormat.mdy.key)
                      .format(requestServicesProvider.date),
                )
                .then((value) => requestServicesProvider.setLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    final OtherServicesProvider otherServicesProvider =
        Provider.of<OtherServicesProvider>(context, listen: false);
    final PackageProvider packageProvider =
        Provider.of<PackageProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).dateTime,
        onTap: () {
          navigateAndFinish(context, const HomeScreen());
          requestServicesProvider.clearServices();
          otherServicesProvider.clearServices();
        },
      ),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                  text: S.of(context).selectDate,
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size15,
                ),
              ],
            ),
            verticalSpace(20),
            CalendarTimeline(
              initialDate: requestServicesProvider.date,
              firstDate: requestServicesProvider.date,
              lastDate: DateTime(
                  requestServicesProvider.date.year + 1,
                  requestServicesProvider.date.month,
                  requestServicesProvider.date.day),
              onDateSelected: (date) async {
                requestServicesProvider.selectedSlotIndex = null;
                otherServicesProvider.selectedTimeSlot();
                packageProvider.selectedSlotIndex = null;

                widget.cameFromPackage
                    ? packageProvider.washesDate[widget.index] =
                        DateFormat(DFormat.ymd.key).format(date)
                    : widget.cameFromOtherServices
                        ? otherServicesProvider.selectedDate =
                            DateFormat(DFormat.ymd.key).format(date)
                        : requestServicesProvider.selectedDate =
                            DateFormat(DFormat.ymd.key).format(date);

                widget.cameFromPackage
                    ? await packageProvider.getPackageTimeSlots(
                        cityId: requestServicesProvider.cityIdData!.id!,
                        packageId: packageProvider
                            .packagesDataList[
                                packageProvider.selectedPackageIndex!]
                            .id!,
                        packageDuration: packageProvider
                            .packagesDataList[
                                packageProvider.selectedPackageIndex!]
                            .duration!,
                        date: DateFormat(DFormat.mdy.key).format(date),
                        /*cityId: 2,
                  packageId: 1,
                  packageDuration: 10,
                  date: "5/15/2022",*/
                      )
                    : widget.cameFromOtherServices
                        ? await otherServicesProvider
                            .getOtherServicesSlots(
                              cityId: requestServicesProvider.cityIdData!.id!,
                              serviceId:
                                  otherServicesProvider.selectedOtherServiceId,
                              duration: otherServicesProvider
                                  .otherServicesList[otherServicesProvider
                                      .selectedServiceIndex!]
                                  .duration!
                                  .toDouble(),
                              date: DateFormat(DFormat.mdy.key).format(date),
                            )
                            .then((value) =>
                                requestServicesProvider.setLoading(false))
                        : await requestServicesProvider
                            .getTimeSlots(
                              cityId: requestServicesProvider.cityIdData!.id!,
                              basicId: requestServicesProvider
                                  .selectedBasicServiceId,
                              duration: requestServicesProvider.totalDuration,
                              date: DateFormat(DFormat.mdy.key).format(date),
                            )
                            .then((value) =>
                                requestServicesProvider.setLoading(false));
              },
              leftMargin: 20,
              showYears: true,
              monthColor: const Color(0xFF565656),
              dayColor: AppColor.boldGrey,
              activeDayColor: Colors.black,
              activeBackgroundDayColor: const Color(0xFFBADEF6),
              dotsColor: const Color(0xFF333A47),
              // selectableDayPredicate: (date) => date.day != 23,
              locale: 'en_ISO',
            ),
            verticalSpace(20),
            TextWidget(
              text: S.of(context).selectTime,
              fontWeight: MyFontWeight.semiBold,
              textSize: MyFontSize.size15,
            ),
            verticalSpace(19),
            widget.cameFromPackage
                ? Consumer<PackageProvider>(
                    builder: (context, value, child) {
                      return Container(
                        child: (value.isLoading)
                            ? const DataLoader()
                            : (value.packageSlotsList.isEmpty)
                                ? CustomSizedBox(
                                    height: 300,
                                    child: Center(
                                        child: TextWidget(
                                            text: S
                                                .of(context)
                                                .noSlotsAvailable)))
                                : Expanded(
                                    child: ListView.separated(
                                      itemCount: value.packageSlotsList.length,
                                      itemBuilder: (context, employeeIndex) {
                                        return CustomContainer(
                                          height: 40,
                                          backgroundColor:
                                              value.selectedSlotIndex ==
                                                      employeeIndex
                                                  ? const Color(0xFFBADEF6)
                                                  : AppColor.borderGreyLight,
                                          borderColor:
                                              value.selectedSlotIndex ==
                                                      employeeIndex
                                                  ? AppColor.borderBlue
                                                  : Colors.transparent,
                                          radiusCircular: 3,
                                          padding: symmetricEdgeInsets(
                                              vertical: 10, horizontal: 12),
                                          onTap: () {
                                            value.slotsIds= [];
                                            value.selectedTimeSlot(
                                                index: employeeIndex);
                                            otherServicesProvider.selectedDate =
                                                DateFormat(DFormat.ymd.key)
                                                    .format(
                                                        requestServicesProvider
                                                            .date);
                                            /* value
                                                .packageSlotsList[employeeIndex]
                                                .forEach((v) {
                                              value.slotsIds.add(v.id);
                                            });*/
                                            value.slotsIds = value
                                                .packageSlotsList[employeeIndex]
                                                .map((e) => e.id)
                                                .toList();
                                            value.washSlotsIdsMap.addEntries({
                                              "${widget.index}": value
                                                  .packageSlotsList[
                                                      employeeIndex]
                                                  .map((e) => e.id)
                                                  .toList()
                                            }.entries);
                                            packageProvider
                                                    .washesTime[widget.index] =
                                                '${value.packageSlotsList[employeeIndex].firstOrNull?.startAt}';
                                            value.employeeIdsList.add(value
                                                .packageSlotsList[employeeIndex]
                                                .firstOrNull
                                                ?.employeeId);
                                            value.slotsIdsList.add(value
                                                .packageSlotsList[employeeIndex]
                                                    [0]
                                                .id);
                                          },
                                          child: Row(
                                            children: [
                                              TextWidget(
                                                text:
                                                    '${value.packageSlotsList[employeeIndex].firstOrNull?.startAt} - ${value.packageSlotsList[employeeIndex].lastOrNull?.endAt}',
                                                fontWeight: MyFontWeight.medium,
                                                textSize: MyFontSize.size10,
                                                color: const Color(0xFF565656),
                                              ),
                                              const Spacer(),
                                              CustomSizedBox(
                                                height: 14,
                                                width: 14,
                                                child:
                                                    value.selectedSlotIndex ==
                                                            employeeIndex
                                                        ? const CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                AppColor
                                                                    .attributeColor,
                                                            child:
                                                                CustomSizedBox(
                                                              width: 6,
                                                              height: 6,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .white,
                                                                radius: 25,
                                                              ),
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            'assets/images/circleGray.png',
                                                          ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          verticalSpace(14),
                                    ),
                                  ),
                      );
                    },
                  )
                : widget.cameFromOtherServices
                    ? Consumer<OtherServicesProvider>(
                        builder: (context, value, child) {
                          return Container(
                            child: (value.isLoading)
                                ? const DataLoader()
                                : (value.slotsList.isEmpty)
                                    ? CustomSizedBox(
                                        height: 300,
                                        child: Center(
                                            child: TextWidget(
                                                text: S
                                                    .of(context)
                                                    .noSlotsAvailable)))
                                    : Expanded(
                                        child: ListView.separated(
                                          itemCount: value.slotsList.length,
                                          itemBuilder:
                                              (context, employeeIndex) {
                                            return CustomContainer(
                                              height: 40,
                                              backgroundColor: value
                                                          .selectedSlotIndex ==
                                                      employeeIndex
                                                  ? const Color(0xFFBADEF6)
                                                  : AppColor.borderGreyLight,
                                              borderColor:
                                                  value.selectedSlotIndex ==
                                                          employeeIndex
                                                      ? AppColor.borderBlue
                                                      : Colors.transparent,
                                              radiusCircular: 3,
                                              padding: symmetricEdgeInsets(
                                                  vertical: 10, horizontal: 12),
                                              onTap: () {
                                                value.slotsIds= [];
                                                value.selectedTimeSlot(
                                                    index: employeeIndex);
                                                otherServicesProvider
                                                    .selectedDate = DateFormat(
                                                        DFormat.ymd.key)
                                                    .format(
                                                        requestServicesProvider
                                                            .date);
                                                value.slotsList[employeeIndex]
                                                    .forEach((v) {
                                                  value.slotsIds.add(v.id);
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  TextWidget(
                                                    text:
                                                        '${value.slotsList[employeeIndex].firstOrNull?.startAt} - ${value.slotsList[employeeIndex].lastOrNull?.endAt}',
                                                    fontWeight:
                                                        MyFontWeight.medium,
                                                    textSize: MyFontSize.size10,
                                                    color:
                                                        const Color(0xFF565656),
                                                  ),
                                                  const Spacer(),
                                                  CustomSizedBox(
                                                    height: 14,
                                                    width: 14,
                                                    child:
                                                        value.selectedSlotIndex ==
                                                                employeeIndex
                                                            ? const CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    AppColor
                                                                        .attributeColor,
                                                                child:
                                                                    CustomSizedBox(
                                                                  width: 6,
                                                                  height: 6,
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .white,
                                                                    radius: 25,
                                                                  ),
                                                                ),
                                                              )
                                                            : Image.asset(
                                                                'assets/images/circleGray.png',
                                                              ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              verticalSpace(14),
                                        ),
                                      ),
                          );
                        },
                      )
                    : Consumer<RequestServicesProvider>(
                        builder: (context, value, child) {
                          return Container(
                            child: (value.isLoading)
                                ? const DataLoader()
                                : (value.slotsList.isEmpty)
                                    ? CustomSizedBox(
                                        height: 300,
                                        child: Center(
                                            child: TextWidget(
                                                text: S
                                                    .of(context)
                                                    .noSlotsAvailable)))
                                    : Expanded(
                                        child: ListView.separated(
                                          itemCount: value.slotsList.length,
                                          itemBuilder:
                                              (context, employeeIndex) {
                                            return CustomContainer(
                                              height: 40,
                                              backgroundColor: value
                                                          .selectedSlotIndex ==
                                                      employeeIndex
                                                  ? const Color(0xFFBADEF6)
                                                  : AppColor.borderGreyLight,
                                              borderColor:
                                                  value.selectedSlotIndex ==
                                                          employeeIndex
                                                      ? AppColor.borderBlue
                                                      : Colors.transparent,
                                              radiusCircular: 3,
                                              padding: symmetricEdgeInsets(
                                                  vertical: 10, horizontal: 12),
                                              onTap: () {
                                                value.slotsIds=[];
                                                value.selectedTimeSlot(
                                                    index: employeeIndex);
                                                otherServicesProvider
                                                    .selectedDate = DateFormat(
                                                        DFormat.ymd.key)
                                                    .format(
                                                        requestServicesProvider
                                                            .date);
                                                value.slotsList[employeeIndex]
                                                    .forEach((v) {
                                                  value.slotsIds.add(v.id);
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  TextWidget(
                                                    text:
                                                        '${value.slotsList[employeeIndex].firstOrNull?.startAt} - ${value.slotsList[employeeIndex].lastOrNull?.endAt}',
                                                    fontWeight:
                                                        MyFontWeight.medium,
                                                    textSize: MyFontSize.size10,
                                                    color:
                                                        const Color(0xFF565656),
                                                  ),
                                                  const Spacer(),
                                                  CustomSizedBox(
                                                    height: 14,
                                                    width: 14,
                                                    child:
                                                        value.selectedSlotIndex ==
                                                                employeeIndex
                                                            ? const CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    AppColor
                                                                        .attributeColor,
                                                                child:
                                                                    CustomSizedBox(
                                                                  width: 6,
                                                                  height: 6,
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .white,
                                                                    radius: 25,
                                                                  ),
                                                                ),
                                                              )
                                                            : Image.asset(
                                                                'assets/images/circleGray.png',
                                                              ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              verticalSpace(14),
                                        ),
                                      ),
                          );
                        },
                      ),
            const Spacer(),
            DefaultButton(
              text: widget.cameFromPackage
                  ? S.of(context).done
                  : S.of(context).pay,
              onPressed: widget.cameFromPackage
                  ? () {
                      Navigator.pop(context);
                    }
                  : widget.cameFromOtherServices
                      ? () {
                          if (otherServicesProvider.selectedSlotIndex != null) {
                            AppLoader.showLoader(context);
                            requestServicesProvider
                                .assignEmployee(
                                    slotsIds: otherServicesProvider.slotsIds,
                                    slotsDate:
                                        otherServicesProvider.selectedDate!,
                                    id: otherServicesProvider
                                        .storeServicesData!.id!)
                                .then((value) {
                              if (value.status == Status.success) {
                                requestServicesProvider
                                    .updateRequestSlots(
                                  requestId: otherServicesProvider
                                      .storeServicesData!.id!,
                                  payBy: "cash",
                                )
                                    .then((value) {
                                  if (value.status == Status.success) {
                                    AppLoader.stopLoader();
                                    navigateTo(
                                      context,
                                      RequestDetails(
                                        cameFromOtherServices: true,
                                        requestId: otherServicesProvider
                                            .storeServicesData!.id!,
                                      ),
                                    );
                                    otherServicesProvider.clearServices();
                                  } else {
                                    AppLoader.stopLoader();
                                    CustomSnackBars.failureSnackBar(
                                        context, '${value.message}');
                                  }
                                });
                              } else {
                                AppLoader.stopLoader();
                                CustomSnackBars.failureSnackBar(
                                    context, '${value.message}');
                              }
                            });
                          } else {
                            CustomSnackBars.failureSnackBar(
                                context, 'Choose time First!');
                          }
                        }
                      : () {
                          if (requestServicesProvider.selectedSlotIndex !=
                              null) {
                            AppLoader.showLoader(context);
                            requestServicesProvider
                                .assignEmployee(
                                    slotsIds: requestServicesProvider.slotsIds,
                                    slotsDate:
                                        requestServicesProvider.selectedDate!,
                                    id: requestServicesProvider
                                        .bookServicesData!.id!)
                                .then((value) {
                              if (value.status == Status.success) {
                                requestServicesProvider
                                    .updateRequestSlots(
                                  requestId: requestServicesProvider
                                      .bookServicesData!.id!,
                                  payBy: "wallet",
                                )
                                    .then((value) {
                                  if (value.status == Status.success) {
                                    AppLoader.stopLoader();
                                    navigateTo(
                                        context,
                                        RequestDetails(
                                          requestId: requestServicesProvider
                                              .bookServicesData!.id!,
                                        ));
                                  } else {
                                    AppLoader.stopLoader();
                                    CustomSnackBars.failureSnackBar(
                                        context, '${value.message}');
                                  }
                                });
                              } else {
                                AppLoader.stopLoader();
                                CustomSnackBars.failureSnackBar(
                                    context, '${value.message}');
                              }
                            });
                          } else {
                            CustomSnackBars.failureSnackBar(
                                context, S.of(context).chooseTimeFirst);
                          }
                        },
              fontWeight: MyFontWeight.bold,
              fontSize: 21,
              height: 48,
              width: 345,
            ),
          ],
        ),
      ),
    );
  }
}
