import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/font_styles.dart';
import '../../../utils/styles/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class RatingDialog extends StatefulWidget {
  RatingDialog({Key? key, this.isRated = false}) : super(key: key);

  bool isRated;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: CustomContainer(
          width: 321,
          radiusCircular: 12,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomSizedBox(
                      height: 55,
                      width: 55,
                      child: ImageEditable(
                        imageUrl: '',
                      ),
                    ),
                    verticalSpace(10),
                    TextWidget(
                      text: 'Mariam Nasser',
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        CustomSizedBox(
                            height: 12,
                            width: 12,
                            child: SvgPicture.asset('assets/svg/alarm.svg')),
                        horizontalSpace(8),
                        TextWidget(
                          text: '03:15 PM',
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
                          text: 'Monday , 23 January 2023',
                          textSize: MyFontSize.size12,
                          fontWeight: MyFontWeight.medium,
                          color: AppColor.grey,
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    TextWidget(
                      text: 'How do you rate the service?',
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                    verticalSpace(10),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        setState(() {
                          widget.isRated = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.isRated,
                child: CustomContainer(
                  width: 321,
                  padding: symmetricEdgeInsets(horizontal: 25, vertical: 6),
                  radiusCircular: 0,
                  clipBehavior: Clip.hardEdge,
                  backgroundColor: const Color(0xFFD8D8D8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        text: 'Feedback',
                        textSize: MyFontSize.size17,
                        fontWeight: MyFontWeight.bold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text:
                        'Please give us feedback about why you rated it 3 stars so we can enhance the problem.',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.medium,
                        color: const Color(0xFF8A8A8A),
                      ),
                      verticalSpace(10),
                      CustomSizedBox(
                          width: 284,
                          height: 62,
                          child: DefaultFormField(
                            height: 62,
                            hintText: 'Type',
                            textSize: MyFontSize.size8,
                            fillColor: const Color(0xFFE0E0E0),
                            filled: true,
                            withBorder: true,

                          )),
                      verticalSpace(10),
                      DefaultButton(
                        height: 39,
                        width: 284,
                        radiusCircular: 3,
                        padding: symmetricEdgeInsets(vertical: 2, horizontal: 4),
                        text: "Submit",
                        fontSize: MyFontSize.size16,
                        fontWeight: MyFontWeight.bold,
                        backgroundColor: const Color(0xFF29A7FF),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
