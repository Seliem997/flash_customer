import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/requests/requestDetails_screen.dart';
import 'package:flash_customer/ui/requests/widgets/request_item.dart';
import 'package:flash_customer/ui/requests/widgets/status_dialog.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/myRequests_provider.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  final GlobalKey listKey = GlobalKey();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase([
              listKey,
            ]));
    super.initState();
  }

  void loadData() async {
    final MyRequestsProvider myRequestsProvider =
        Provider.of<MyRequestsProvider>(context, listen: false);
    myRequestsProvider.setLoading(true);
    myRequestsProvider.filterDateText = null;
    myRequestsProvider.filterDateStatus = null;
    myRequestsProvider.selectedDateFrom = null;
    myRequestsProvider.selectedDateTo = null;
    await myRequestsProvider.getMyRequests();
  }

  @override
  Widget build(BuildContext context) {
    final MyRequestsProvider myRequestsProvider =
        Provider.of<MyRequestsProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).myRequests, onArrowPressed: (){
        navigateAndFinish(context, const HomeScreen());
      }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: onlyEdgeInsets(
                top: 40,
                start: 24,
              ),
              child: Row(
                children: [
                  DefaultButtonWithIcon(
                    padding: symmetricEdgeInsets(horizontal: 10),
                    icon: SvgPicture.asset('assets/svg/filter.svg',
                        color: MyApp.themeMode(context) ? Colors.white : null),
                    onPressed: () {

                      showDateRangePicker(
                              context: context,
                              firstDate: DateTime.utc(DateTime.now().year),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 180)))
                          .then((value) {
                        if (value != null) {
                          myRequestsProvider.selectedDateFrom = value.start;
                          myRequestsProvider.selectedDateTo = value.end;
                        }
                      });
                    },
                    labelText: myRequestsProvider.filterDateText != null
                        ? myRequestsProvider.filterDateText!
                        : S.of(context).dateFilter,
                    textColor: AppColor.boldGrey,
                    backgroundButton: const Color(0xFFF0F0F0),
                    borderColor: AppColor.boldGrey,
                    border: true,
                  ),
                  horizontalSpace(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultButtonWithIcon(
                      padding: symmetricEdgeInsets(horizontal: 10),
                      icon: SvgPicture.asset(
                        'assets/svg/filter.svg',
                        color: MyApp.themeMode(context) ? Colors.white : null,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const StatusDialog();
                          },
                        );
                      },
                      labelText: myRequestsProvider.filterDateStatus != null
                          ? myRequestsProvider.filterDateStatus!
                          : S.of(context).statusFilter,
                      textColor: AppColor.boldGrey,
                      backgroundButton: const Color(0xFFF0F0F0),
                      borderColor: AppColor.boldGrey,
                      border: true,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(24),
            (myRequestsProvider.loadingMyRequests)
                ? const DataLoader()
                : (myRequestsProvider.myRequestsDataList.isEmpty)
                    ? CustomSizedBox(
                        height: 500,
                        child: Center(
                            child: TextWidget(
                                text: S.of(context).noRequestsAvailable)))
                    : Padding(
                        padding: symmetricEdgeInsets(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Showcase(
                              key: listKey,
                              description: S.of(context).swipeAnyOrderToCancel,
                              child: CustomContainer(
                                width: double.infinity,
                                height: 560,
                                borderColorDark: Colors.transparent,
                                child: ShowCaseWidget(
                                    builder: Builder(builder: (context) {
                                  return ListView.separated(
                                    itemCount: myRequestsProvider
                                        .myRequestsDataList.length,
                                    itemBuilder: (context, index) {
                                      if (myRequestsProvider
                                              .myRequestsDataList[index]
                                              .status ==
                                          "Canceled"
                                          || myRequestsProvider.myRequestsDataList[index].status == "Complete") {
                                        return RequestItem(
                                          myRequestData: myRequestsProvider
                                              .myRequestsDataList[index],
                                          onTap: () {
                                            navigateTo(
                                                context,
                                                RequestDetailsScreen(
                                                  requestId: myRequestsProvider
                                                      .myRequestsDataList[index]
                                                      .id!,
                                                ));
                                          },
                                        );
                                      } else if ( myRequestsProvider.myRequestsDataList[index].washNumber != null &&  myRequestsProvider.myRequestsDataList[index].washNumber != 1) {
                                        return RequestItem(
                                          myRequestData: myRequestsProvider
                                              .myRequestsDataList[index],
                                          onTap: () {
                                            navigateTo(
                                                context,
                                                RequestDetailsScreen(
                                                  requestId: myRequestsProvider
                                                      .myRequestsDataList[index]
                                                      .id!,
                                                ));
                                          },
                                        );
                                      } else {
                                        return Slidable(
                                          key: ValueKey(index),
                                          useTextDirection: true,
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                flex: 1,
                                                onPressed:
                                                    (BuildContext context) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Padding(
                                                          padding:
                                                              onlyEdgeInsets(
                                                                  top: 40,
                                                                  bottom: 32,
                                                                  end: 38,
                                                                  start: 38),
                                                          child: TextWidget(
                                                            textAlign: TextAlign
                                                                .center,
                                                            text: S
                                                                .of(context)
                                                                .areYouSureToCancel,
                                                            textSize: MyFontSize
                                                                .size17,
                                                            fontWeight:
                                                                MyFontWeight
                                                                    .semiBold,
                                                            colorDark:
                                                                Colors.black,
                                                          ),
                                                        ),
                                                        actions: [
                                                          Padding(
                                                            padding:
                                                                symmetricEdgeInsets(
                                                                    vertical:
                                                                        5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                DefaultButton(
                                                                  width: 90,
                                                                  height: 30,
                                                                  text: S
                                                                      .of(context)
                                                                      .no,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .lightRed,
                                                                ),
                                                                horizontalSpace(
                                                                    20),
                                                                DefaultButton(
                                                                  width: 100,
                                                                  height: 30,
                                                                  text: S
                                                                      .of(context)
                                                                      .yes,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    myRequestsProvider
                                                                        .updateRequestStatus(
                                                                            requestId:
                                                                                myRequestsProvider.myRequestsDataList[index].id!,
                                                                            status: 'canceled')
                                                                        .then((value) {});
                                                                  },
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .primary,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                backgroundColor:
                                                    const Color(0xFFE74A2A),
                                                foregroundColor: Colors.white,
                                                icon: Icons
                                                    .delete_forever_outlined,
                                                label: S.of(context).cancel,
                                              ),
                                            ],
                                          ),
                                          child: RequestItem(
                                            myRequestData: myRequestsProvider
                                                .myRequestsDataList[index],
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  RequestDetailsScreen(
                                                    requestId:
                                                        myRequestsProvider
                                                            .myRequestsDataList[
                                                                index]
                                                            .id!,
                                                  ));
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    separatorBuilder: (context, index) =>
                                        verticalSpace(14),
                                  );
                                })),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
