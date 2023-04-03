import 'package:flash_customer/ui/services/widgets/services_widgets.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/services_provider.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/data_loader.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final ServicesProvider servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);

    await servicesProvider.getBasicServices();
    await servicesProvider.getExtraServices();
  }

  @override
  Widget build(BuildContext context) {
    final ServicesProvider servicesProvider =
        Provider.of<ServicesProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Services'),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 41),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Basic Services',
                textSize: MyFontSize.size16,
                fontWeight: MyFontWeight.semiBold,
                color: const Color(0xFF4B4B4B),
              ),
              verticalSpace(14),
              CustomContainer(
                width: 345,
                height: 322,
                radiusCircular: 4,
                backgroundColor: const Color(0xFFF9F9F9),
                child: servicesProvider.basicServicesList.isEmpty
                    ? const DataLoader()
                    : Padding(
                  padding: onlyEdgeInsets(
                    start: 11,
                    end: 21,
                    bottom: 22,
                    top: 22,
                  ),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => BasicServicesWidget(
                        title: servicesProvider.basicServicesList[index].title!,
                        imageName:
                            servicesProvider.basicServicesList[index].image!,
                      onTap: (){
                        servicesProvider.checkBasicService();
                      },
                      onCheck: servicesProvider.onCheck,
                      infoOnPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextWidget(
                                  text: '${servicesProvider.basicServicesList[index].info}',
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: symmetricEdgeInsets(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      DefaultButton(
                                        width: 130,
                                        height: 30,
                                        text: 'Cancel',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        backgroundColor: const Color(0xFF6BB85F),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => verticalSpace(14),
                    itemCount: servicesProvider.basicServicesList.length,
                  ),
                ),
              ),
              verticalSpace(40),
              TextWidget(
                text: 'Extra Services',
                textSize: MyFontSize.size16,
                fontWeight: MyFontWeight.semiBold,
                color: const Color(0xFF4B4B4B),
              ),
              verticalSpace(14),
              CustomContainer(
                width: 345,
                height: 322,
                radiusCircular: 4,
                backgroundColor: const Color(0xFFF9F9F9),
                child: servicesProvider.extraServicesList.isEmpty
                    ? const DataLoader()
                    : Padding(
                  padding: onlyEdgeInsets(
                    start: 11,
                    end: 21,
                    bottom: 22,
                    top: 22,
                  ),
                  child:  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => BasicServicesWidget(
                      title: servicesProvider.extraServicesList[index].title!,
                      imageName:
                      servicesProvider.extraServicesList[index].image!,
                      onTap: (){
                        servicesProvider.checkBasicService();
                      },
                      onCheck: servicesProvider.onCheck,
                      infoOnPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextWidget(
                                  text: '${servicesProvider.extraServicesList[index].info}',
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: symmetricEdgeInsets(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      DefaultButton(
                                        width: 130,
                                        height: 30,
                                        text: 'Cancel',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        backgroundColor: const Color(0xFF6BB85F),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => verticalSpace(14),
                    itemCount: servicesProvider.extraServicesList.length,
                  ),
                  /*child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFE1ECFF),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                              ),
                              CustomSizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Image.asset(
                                      'assets/images/chair_image.png')),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'One chair Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: Row(
                                  children: [
                                    CustomSizedBox(
                                      width: 18,
                                      height: 23,
                                      child: Image.asset(
                                          'assets/images/minus.png'),
                                    ),
                                    horizontalSpace(9),
                                    TextWidget(
                                      text: '1',
                                      fontWeight: MyFontWeight.bold,
                                      textSize: MyFontSize.size12,
                                    ),
                                    horizontalSpace(9),
                                    CustomSizedBox(
                                      width: 18,
                                      height: 23,
                                      child:
                                          Image.asset('assets/images/plus.png'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFD1D1D1),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                                // child: Icon(Icons.info, size: 20, color: AppColor.primary),
                              ),
                              CustomSizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/extraServices_image.png'),
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'All chair Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.dark,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: const CustomContainer(
                                  radiusCircular: 5,
                                  backgroundColor: Colors.transparent,
                                  height: 19,
                                  width: 20,
                                  borderColor: Color(0xFF393939),
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFD1D1D1),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                                // child: Icon(Icons.info, size: 20, color: AppColor.primary),
                              ),
                              CustomSizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/basicServices_image.png'),
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'Inside Only Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.dark,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: const CustomContainer(
                                  radiusCircular: 5,
                                  backgroundColor: Colors.transparent,
                                  height: 19,
                                  width: 20,
                                  borderColor: Color(0xFF393939),
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(14),
                        CustomContainer(
                          height: 59,
                          width: 313,
                          backgroundColor: const Color(0xFFD1D1D1),
                          radiusCircular: 4,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: const Icon(Icons.info,
                                      size: 20, color: AppColor.primary),
                                  onPressed: () {},
                                ),
                                // child: Icon(Icons.info, size: 20, color: AppColor.primary),
                              ),
                              CustomSizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/basicServices_image.png'),
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: 'Inside Only Wash',
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.dark,
                              ),
                              const Spacer(),
                              Padding(
                                padding: onlyEdgeInsets(
                                  end: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: const CustomContainer(
                                  radiusCircular: 5,
                                  backgroundColor: Colors.transparent,
                                  height: 19,
                                  width: 20,
                                  borderColor: Color(0xFF393939),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ),
              ),
              verticalSpace(25),
              Row(
                children: [
                  CustomSizedBox(
                      height: 18,
                      width: 18,
                      child: Image.asset('assets/images/clock.png')),
                  horizontalSpace(4),
                  TextWidget(
                    text: 'Service Duration :',
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.bold,
                  ),
                  TextWidget(
                    text: ' 50 Min',
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.medium,
                    color: const Color(0xFF686868),
                  ),
                ],
              ),
              verticalSpace(25),
              CustomContainer(
                width: 345,
                height: 235,
                borderColor: AppColor.primary,
                backgroundColor: const Color(0xFFF1F6FE),
                child: Padding(
                  padding: symmetricEdgeInsets(vertical: 24, horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            text: 'Amount :',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '154 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Tax :',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '15 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Discount code : ',
                            textSize: MyFontSize.size14,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          CustomContainer(
                            width: 112,
                            height: 24,
                            radiusCircular: 3,
                            backgroundColor: AppColor.buttonGrey,
                            borderColor: AppColor.boldGrey,
                            child: Center(
                              child: CustomTextForm(
                                contentPadding:
                                    onlyEdgeInsets(start: 10, bottom: 8),
                                textInputAction: TextInputAction.done,
                                hintText: '',
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextWidget(
                            text: 'Remove',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: AppColor.textRed,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            symmetricEdgeInsets(horizontal: 10, vertical: 28),
                        child: const Divider(
                          color: Color(0xFF898A8D),
                        ),
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Total Amount :',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '240 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(64),
              DefaultButton(
                width: 345,
                height: 48,
                text: 'Book',
                fontSize: 21,
                fontWeight: MyFontWeight.bold,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
