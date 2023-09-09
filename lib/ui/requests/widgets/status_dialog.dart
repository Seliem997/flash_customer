import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/myRequests_provider.dart';
import '../../../utils/enum/status_types.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class StatusDialog extends StatefulWidget {
  const StatusDialog({Key? key}) : super(key: key);

  @override
  State<StatusDialog> createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  String? statusType;

  @override
  Widget build(BuildContext context) {
    final MyRequestsProvider myRequestsProvider =
    Provider.of<MyRequestsProvider>(context);

    return Dialog(
      child: CustomContainer(
        width: 321,
        padding: symmetricEdgeInsets(horizontal: 10, vertical: 20),
        radiusCircular: 12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: symmetricEdgeInsets(horizontal: 22),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: TextWidget(
                  text: S.of(context).listOfStatus,
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size18,
                ),
              ),
            ),
            verticalSpace(24),
            RadioListTile(
              title: TextWidget(
                text: S.of(context).pending,
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Pending",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                  myRequestsProvider.getMyRequests(status: StatusType.pending2.key);
                  Navigator.pop(context);
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: S.of(context).onTheWay,
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "On the way",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                  myRequestsProvider.getMyRequests(status: StatusType.onTheWay2.key);
                  Navigator.pop(context);
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: S.of(context).arrived,
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Arrived",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                  myRequestsProvider.getMyRequests(status: StatusType.arrived2.key);
                  Navigator.pop(context);
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: S.of(context).completed,
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Completed",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                  myRequestsProvider.getMyRequests(status: StatusType.completed2.key);
                  Navigator.pop(context);
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: S.of(context).canceled,
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Canceled",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                  myRequestsProvider.getMyRequests(status: StatusType.canceled2.key);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
