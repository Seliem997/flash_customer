import 'package:flash_customer/ui/requests/requestDetails_screen.dart';
import 'package:flash_customer/ui/requests/request_details.dart';
import 'package:flash_customer/ui/requests/widgets/request_item.dart';
import 'package:flash_customer/ui/requests/widgets/status_dialog.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/myRequests_provider.dart';
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
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final MyRequestsProvider myRequestsProvider =
        Provider.of<MyRequestsProvider>(context, listen: false);
    myRequestsProvider.setLoading(true);
    await myRequestsProvider.getMyRequests();
  }

  @override
  Widget build(BuildContext context) {
    final MyRequestsProvider myRequestsProvider =
        Provider.of<MyRequestsProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).myRequests),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: onlyEdgeInsets(top: 40, start: 24, ),
              child: Row(
                children: [
                  /*DefaultButtonWithIcon(
                    padding: symmetricEdgeInsets(horizontal: 10),
                    icon: SvgPicture.asset('assets/svg/filter.svg'),
                    onPressed: () {},
                    labelText: S.of(context).dateFilter,
                    textColor: AppColor.boldGrey,
                    backgroundButton: const Color(0xFFF0F0F0),
                    borderColor: AppColor.boldGrey,
                    border: true,
                  ),*/
                  horizontalSpace(20),
                  DefaultButtonWithIcon(
                    padding: symmetricEdgeInsets(horizontal: 10),
                    icon: SvgPicture.asset('assets/svg/filter.svg',color: MyApp.themeMode(context) ? Colors.white : Colors.black,),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const StatusDialog();
                        },
                      );
                    },
                    labelText: S.of(context).statusFilter,
                    textColor: AppColor.boldGrey,
                    backgroundButton: const Color(0xFFF0F0F0),
                    borderColor: AppColor.boldGrey,
                    border: true,
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

                            CustomContainer(
                              width: double.infinity,
                              height: 560,
                              borderColorDark: Colors.transparent,
                              child: ListView.separated(
                                itemCount:
                                    myRequestsProvider.myRequestsDataList.length,
                                itemBuilder: (context, index) => RequestItem(
                                  myRequestData:
                                      myRequestsProvider.myRequestsDataList[index],
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        RequestDetailsScreen(
                                          requestId: myRequestsProvider
                                              .myRequestsDataList[index].id!,
                                        ));
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    verticalSpace(14),
                              ),
                            ),
                            /*RequestItem(),*/
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
