import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/font_styles.dart';
import '../../providers/requestServices_provider.dart';
import '../requests/request_details.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigate.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {

  var date = DateTime.now();

  // Widget cellBuilder(BuildContext context, DateRangePickerCellDetails details) {
  //   final bool isSelected = _controller.selectedDate != null &&
  //       details.date.year == _controller.selectedDate!.year &&
  //       details.date.month == _controller.selectedDate!.month &&
  //       details.date.day == _controller.selectedDate!.day;
  //   if (isSelected) {
  //     return Column(
  //       children: [
  //         Container(
  //           child: Text(
  //             details.date.day.toString(),
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(color: Colors.white),
  //           ),
  //         ),
  //         Container(
  //             child: Text(
  //           DateFormat('EEE').format((details.date)),
  //           style: const TextStyle(color: Colors.white),
  //         )),
  //       ],
  //     );
  //   } else {
  //     return Container(
  //       child: Text(
  //         details.date.day.toString(),
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(color: Colors.tealAccent),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context, listen: false);
    
   /* final PackageProvider packageProvider =
    Provider.of<PackageProvider>(context, listen: false);
    final MyVehiclesProvider myVehiclesProvider =
    Provider.of<MyVehiclesProvider>(context, listen: false);
   
    final HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    await packageProvider.getVehiclesTypeActive();
    await packageProvider.getManufacturersOfType(
        vehicleTypeId: packageProvider.vehicleTypeId);
    await myVehiclesProvider.getMyVehicles();
    await requestServicesProvider.getCityId(
      context,
      lat: homeProvider.currentPosition!.latitude,
      long: homeProvider.currentPosition!.longitude,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context);
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Date & Time '),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                  text: 'Select Date',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size15,
                ),
                /* const Spacer(),
                CustomContainer(
                  width: 55,
                  height: 24,
                  radiusCircular: 3,
                  borderColor: const Color(0xFF979797),
                  child: Padding(
                    padding: symmetricEdgeInsets(horizontal: 4),
                    child: Row(
                      children: [
                        TextWidget(
                          text: 'Jan',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF909090),
                        ),
                        horizontalSpace(8),
                        SvgPicture.asset(
                          'assets/svg/arrow_down.svg',
                        )
                      ],
                    ),
                  ),
                ),
                horizontalSpace(8),
                CustomContainer(
                  width: 65,
                  height: 24,
                  radiusCircular: 3,
                  borderColor: const Color(0xFF979797),
                  child: Padding(
                    padding: symmetricEdgeInsets(horizontal: 4),
                    child: Row(
                      children: [
                        TextWidget(
                          text: '2023',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF909090),
                        ),
                        horizontalSpace(11),
                        SvgPicture.asset(
                          'assets/svg/arrow_down.svg',
                        )
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
            verticalSpace(20),
            CalendarTimeline(
              initialDate: date,
              firstDate: date,
              lastDate: DateTime(date.year + 1, date.month, date.day),
              onDateSelected: (date) => print(date),
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
              text: 'Select Time',
              fontWeight: MyFontWeight.semiBold,
              textSize: MyFontSize.size15,
            ),
            verticalSpace(19),
            CustomContainer(
              height: 40,
              backgroundColor: AppColor.borderGreyLight,
              radiusCircular: 3,
              padding: symmetricEdgeInsets(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  TextWidget(
                    text: '03:30 PM',
                    fontWeight: MyFontWeight.medium,
                    textSize: MyFontSize.size10,
                    color: const Color(0xFF565656),
                  ),
                  const Spacer(),
                  CustomSizedBox(height: 14,width: 14,child: Image.asset('assets/images/circleGray.png',),),
                ],
              ),
            ),
            verticalSpace(14),
            CustomContainer(
              height: 40,
              backgroundColor: AppColor.borderGreyLight,
              radiusCircular: 3,
              padding: symmetricEdgeInsets(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  TextWidget(
                    text: '04:30 PM',
                    fontWeight: MyFontWeight.medium,
                    textSize: MyFontSize.size10,
                    color: const Color(0xFF565656),
                  ),
                  const Spacer(),
                  CustomSizedBox(height: 14,width: 14,child: Image.asset('assets/images/circleGray.png',),),
                ],
              ),
            ),
            verticalSpace(14),
            CustomContainer(
              height: 40,
              backgroundColor: const Color(0xFFBADEF6),
              borderColor: AppColor.borderBlue,
              radiusCircular: 3,
              padding: symmetricEdgeInsets(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  TextWidget(
                    text: '04:30 PM',
                    fontWeight: MyFontWeight.medium,
                    textSize: MyFontSize.size10,
                    color: const Color(0xFF565656),
                  ),
                  const Spacer(),
                  const CustomSizedBox(height: 14,width: 14, child: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColor.attributeColor,
                    child: CustomSizedBox(
                      width: 6,
                      height: 6,
                      child: CircleAvatar(
                        backgroundColor: AppColor.white,
                        radius: 25,
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
            verticalSpace(14),
            const Spacer(),
            DefaultButton(
              text: 'Pay',
              onPressed: () {
                requestServicesProvider.updateRequestSlots(
                  requestId: requestServicesProvider.bookServicesData!.requestId!,
                  offerCode: requestServicesProvider.couponData!.code!,
                    employeeID: 5,
                    payBy: "wallet",
                ).then((value) {
                  navigateTo(context, const RequestDetails());
                });
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
