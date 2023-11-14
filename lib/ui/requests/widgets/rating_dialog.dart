import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/myRequestsModel.dart';
import '../../../providers/requestServices_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/enum/statuses.dart';
import '../../../utils/font_styles.dart';
import '../../../utils/snack_bars.dart';
import '../../../utils/styles/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class RatingDialog extends StatefulWidget {
  RatingDialog({Key? key, this.isRated = false, required this.myRequestData}) : super(key: key);

  bool isRated;
  final MyRequestsData myRequestData;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context);
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);
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
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: CachedNetworkImageProvider(widget.myRequestData.employee?.image ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0F6JSOHkKNsDAnJo3mBl98s0JXJ4dheYY-0jWCUjFJ0tiW6VyPfLJ_wQP&s=10"),
                    ),
                    verticalSpace(10),
                    TextWidget(
                      text: widget.myRequestData.employee?.name == ""
                          ? S.of(context).userName
                          : widget.myRequestData.employee?.name ?? S.of(context).userName,
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.semiBold,
                      colorDark: Colors.black,
                    ),
                    verticalSpace(20),
                    TextWidget(
                      text: S.of(context).howDoYouRateTheService,
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.semiBold,
                      colorDark: Colors.black,
                    ),
                    verticalSpace(10),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        requestServicesProvider.ratingValue= rating.toInt();
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
                      Visibility(
                        visible: requestServicesProvider.ratingValue < 4,
                        child: Column(
                          children: [
                            TextWidget(
                              text: S.of(context).feedback,
                              textSize: MyFontSize.size17,
                              fontWeight: MyFontWeight.bold,
                              colorDark: Colors.black,
                            ),
                            verticalSpace(10),
                            TextWidget(
                              text: S
                                  .of(context)
                                  .pleaseGiveUsFeedbackAboutWhyYouRatedItSo,
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: const Color(0xFF8A8A8A),
                              colorDark: Colors.black,
                            ),
                            verticalSpace(10),
                            CustomSizedBox(
                                width: 284,
                                height: 62,
                                child: DefaultFormField(
                                  controller: requestServicesProvider.ratingFeedbackController,
                                  height: 62,
                                  hintText: S.of(context).type,
                                  textSize: MyFontSize.size8,
                                  fillColor: const Color(0xFFE0E0E0),
                                  filled: true,
                                  withBorder: true,
                                )),
                          ],
                        ),
                      ),
                      verticalSpace(10),
                      DefaultButton(
                        height: 39,
                        width: 284,
                        radiusCircular: 3,
                        padding:
                            symmetricEdgeInsets(vertical: 2, horizontal: 4),
                        text: S.of(context).submit,
                        fontSize: MyFontSize.size16,
                        fontWeight: MyFontWeight.bold,
                        backgroundColor: const Color(0xFF29A7FF),
                        onPressed: () {
                          AppLoader.showLoader(context);
                          requestServicesProvider.rateRequest(
                            requestId: widget.myRequestData.id!, rate: requestServicesProvider.ratingValue, feedBack: requestServicesProvider.ratingFeedbackController.text,
                          ).then((value) {
                            AppLoader.stopLoader();
                            if(value.status == Status.success){
                              CustomSnackBars.successSnackBar(
                                  context, 'Request Rated Successfully');
                              navigateAndFinish(context, const HomeScreen(cameFromNewRequest: true,));
                            }else{
                              CustomSnackBars.failureSnackBar(context, '${value.message}');
                            }

                          });
                        },
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
