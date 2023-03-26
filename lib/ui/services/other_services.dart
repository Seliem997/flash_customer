import 'package:flash_customer/ui/services/waxing_services/waxing_services.dart';
import 'package:flash_customer/ui/services/widgets/services_widgets.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/otherServices_provider.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';
import '../widgets/text_widget.dart';

class OtherServices extends StatefulWidget {
  const OtherServices({Key? key}) : super(key: key);

  @override
  State<OtherServices> createState() => _OtherServicesState();
}

class _OtherServicesState extends State<OtherServices> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final OtherServicesProvider otherServicesProvider=Provider.of<OtherServicesProvider>(context, listen: false);

    otherServicesProvider.getOtherServices();
  }

  @override
  Widget build(BuildContext context) {
    final OtherServicesProvider otherServicesProvider=Provider.of<OtherServicesProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Other Services'),
      body: otherServicesProvider.otherServicesList.isEmpty
          ? const DataLoader()
          : Padding(
        padding: symmetricEdgeInsets(horizontal: 12, vertical: 40),
        child: Padding(
          padding: onlyEdgeInsets(start: 11),
          /*child: Wrap(
            runSpacing: (11 / screenHeight * 100).h,
            children: [
              const ServicesItem(
                title: 'House Cleaning',
                imageName: 'assets/images/house.png',
                serviceValue: '50 SR',
                serviceUnit: 'Hour',
              ),
              const ServicesItem(
                title: 'House Cleaning',
                imageName: 'assets/images/furniture.png',
                serviceValue: '50SR',
                serviceUnit: 'Metr',
              ),
              ServicesItem(
                title: 'Waxing services',
                imageName: 'assets/images/wax.png',
                seeMore: true,
                onTap: (){
                  navigateTo(context, const WaxingServices());
                },
              ),
              const ServicesItem(
                title: 'Lorem ipsum',
                imageName: 'assets/images/oil.png',
                serviceValue: '50 SR',
                serviceUnit: 'Hour',
              ),
              const ServicesItem(
                title: 'Lorem ipsum',
                imageName: 'assets/images/cleaning.png',
                serviceValue: '50 SR',
                serviceUnit: 'Hour',
                onlyValue: true,
              ),
            ],
          ),*/
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: otherServicesProvider.otherServicesList.length,
            itemBuilder: (context, index) {
              return  ServicesItem(
                title: otherServicesProvider.otherServicesList[index].name!,
                imageName: otherServicesProvider.otherServicesList[index].image!,
                serviceValue: '45',
                // serviceValue: '${otherServicesProvider.otherServicesList[index].cities![0].price!.value} ${otherServicesProvider.otherServicesList[index].cities![index].price!.unit}',
                serviceUnit: otherServicesProvider.otherServicesList[index].deal,
                infoOnPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextWidget(
                            text: otherServicesProvider.otherServicesList[index].info!,
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
              );
            },
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 200,
            ),
          ),
        ),
      ),
    );
  }
}

