import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/font_styles.dart';
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
  // final DateRangePickerController _controller = DateRangePickerController();
  final List<String> _months = <String>[
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ];
  final bool _selected = false;
  final int _selectedIndex = -1;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Date & Time '),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
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
            /*SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: const Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: const Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: const Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: const Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: const Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: const Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: const Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                ],
              ),
            ),*/
            /* verticalSpace(40),
            CustomSizedBox(
              height: 400,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _months.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected = true;
                            _selectedIndex = index;
                            _controller.displayDate =
                                DateTime(2021, _selectedIndex, 1, 9, 0, 0);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          height: 2,
                          color: Color(0xFF192841),
                          child: Column(
                            children: [
                              Container(
                                  child: Text(_months[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: _selected &&
                                                  _selectedIndex == index
                                              ? FontWeight.w900
                                              : FontWeight.w400))),
                              verticalSpace(10),
                              SfDateRangePicker(
                                backgroundColor: Color(0xFF192841),
                                controller: _controller,
                                selectionColor: Colors.red.shade400,
                                view: DateRangePickerView.month,
                                headerHeight: 0,
                                cellBuilder: cellBuilder,
                                monthViewSettings:
                                    DateRangePickerMonthViewSettings(
                                        viewHeaderHeight: 0,
                                        numberOfWeeksInView: 1),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),*/
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
            const Spacer(),
            DefaultButton(
              text: 'Pay',
              onPressed: () {
                navigateTo(context, const RequestDetails());
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
