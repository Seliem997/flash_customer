import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/notifications_provider.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);
    await notificationsProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: S.of(context).notifications,
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: CustomContainer(
        borderColorDark: Colors.transparent,
        padding: symmetricEdgeInsets(horizontal: 25),
        child: notificationsProvider.loadingNotifications
            ? const DataLoader()
            : notificationsProvider.notifications!.isEmpty
                ? const NoDataPlaceHolder(useExpand: false)
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: notificationsProvider.notifications!.length,
                    itemBuilder: (context, index) {
                      return CustomContainer(
                        padding:
                            symmetricEdgeInsets(horizontal: 15, vertical: 10),
                        radiusCircular: 5,
                        height: 105,
                        backgroundColor: AppColor.borderGrey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomContainer(
                                  width: 220,
                                  borderColorDark: Colors.transparent,
                                  child: TextWidget(
                                    text:
                                        "${notificationsProvider.notifications![index].content}",
                                    textSize: 13,
                                    height: 1.2,
                                    maxLines: 3,
                                  ),
                                ),
                                // CustomContainer(
                                //   width: 78,
                                //   height: 65,
                                //   radiusCircular: 5,
                                //   borderColorDark: Colors.transparent,
                                //   image: DecorationImage(
                                //       image: AssetImage("assets/images/Nature.png"),
                                //       fit: BoxFit.cover),
                                // )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 12,
                                  color: Color(0xff616161),
                                ),
                                horizontalSpace(15),
                                TextWidget(
                                  text:
                                      "${notificationsProvider.notifications![index].time} - ${notificationsProvider.notifications![index].date}",
                                  textSize: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => verticalSpace(20)),
      ),
    );
  }
}
