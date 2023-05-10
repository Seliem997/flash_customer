import 'package:flutter/material.dart';

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
                  text: 'List of status :',
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size18,
                ),
              ),
            ),
            verticalSpace(24),
            RadioListTile(
              title: TextWidget(
                text: 'Pending',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Pending",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: 'On the way',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "On the way",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: 'Arrived',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Arrived",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: 'Completed',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Completed",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: TextWidget(
                text: 'Canceled',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium,
                color: const Color(0xFF282828),
              ),
              value: "Canceled",
              groupValue: statusType,
              onChanged: (value) {
                setState(() {
                  statusType = value.toString();
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
