import 'package:flash_customer/ui/requests/widgets/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/myRequestsModel.dart';
import '../../../utils/font_styles.dart';
import '../../../utils/styles/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/navigate.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    Key? key,
    required this.myRequestData,
    this.onTap,
  }) : super(key: key);

  final MyRequestsData myRequestData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String services = '';
    for (int i = 0; i < myRequestData.services!.length; i++) {
      services += "${myRequestData.services![i].title}, ";
    }
    return CustomContainer(
      onTap: onTap,
      width: 345,
      radiusCircular: 6,
      borderColor: AppColor.borderGreyLight,
      backgroundColor: AppColor.borderGreyLight,
      padding: symmetricEdgeInsets(vertical: 13, horizontal: 13),
      child: Column(
        children: [
          Row(
            children: [
              TextWidget(
                text: S.of(context).services,
                textSize: MyFontSize.size12,
                fontWeight: MyFontWeight.semiBold,
              ),
              Expanded(
                child: TextWidget(
                  text: services,
                  textSize: MyFontSize.size10,
                  fontWeight: MyFontWeight.medium,
                  color: AppColor.grey,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Row(
            children: [
              CustomSizedBox(
                  height: 12,
                  width: 12,
                  child: SvgPicture.asset('assets/svg/alarm.svg')),
              horizontalSpace(8),
              TextWidget(
                text: '${myRequestData.time}',
                textSize: MyFontSize.size10,
                fontWeight: MyFontWeight.medium,
                color: AppColor.grey,
              ),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              const CustomSizedBox(
                height: 12,
                width: 12,
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: Color(0xff616161),
                ),
              ),
              horizontalSpace(8),
              TextWidget(
                text: '${myRequestData.date}',
                textSize: MyFontSize.size12,
                fontWeight: MyFontWeight.medium,
                color: AppColor.grey,
              ),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              CustomSizedBox(
                height: 12,
                width: 12,
                child: SvgPicture.asset('assets/svg/profile.svg',
                    color: AppColor.grey),
              ),
              horizontalSpace(8),
              TextWidget(
                text: myRequestData.employee?.name ?? S.of(context).noEmployee,
                textSize: MyFontSize.size12,
                fontWeight: MyFontWeight.medium,
                color: AppColor.grey,
              ),
            ],
          ),
          Visibility(visible: myRequestData.status == 'Complete', child: verticalSpace(10)),
          Visibility(
            visible: myRequestData.status == 'Complete',
            child: Row(
              children: [
                TextWidget(
                  text: S.of(context).rate,
                  textSize: MyFontSize.size12,
                  fontWeight: MyFontWeight.semiBold,
                ),
                horizontalSpace(8),
                CustomSizedBox(
                  height: 15,
                  width: 100,
                  child: myRequestData.rate == null
                      ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>CustomSizedBox(
                      height: 12,
                      width: 12,
                      child: Image.asset('assets/images/star.png')),
                      separatorBuilder: (context, index) => horizontalSpace(4), itemCount: 5,)
                      : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>CustomSizedBox(
                      height: 12,
                      width: 12,
                      child: Image.asset('assets/images/star.png',color: Colors.amber),),
                      separatorBuilder: (context, index) => horizontalSpace(4), itemCount: myRequestData.rate,),
                ),
                horizontalSpace(6),
                myRequestData.rate == null ? DefaultButton(
                  height: 20,
                  width: 50,
                  radiusCircular: 3,
                  padding: symmetricEdgeInsets(vertical: 2, horizontal: 4),
                  text: 'Rate',
                  fontSize: MyFontSize.size9,
                  fontWeight: MyFontWeight.semiBold,
                  backgroundColor: const Color(0xFF03B7FD),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RatingDialog(requestId: myRequestData.id!,);
                      },
                    );
                  },
                ) : const SizedBox(),
              ],
            ),
          ),
          verticalSpace(10),
          Row(
            children: [
              TextWidget(
                text: S.of(context).amount,
                textSize: MyFontSize.size12,
                fontWeight: MyFontWeight.semiBold,
              ),
              TextWidget(
                text: '${myRequestData.totalAmount}',
                textSize: MyFontSize.size10,
                fontWeight: MyFontWeight.bold,
                color: AppColor.borderBlue,
              ),
              const Spacer(),
              DefaultButton(
                height: 21,
                width: 64,
                padding: EdgeInsets.zero,
                text: "${myRequestData.status}",
                fontSize: MyFontSize.size9,
                fontWeight: MyFontWeight.semiBold,
                backgroundColor: myRequestData.status == 'Complete'
                    ? Colors.green
                    : AppColor.textRed,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
