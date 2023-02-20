import 'package:flash_customer/ui/services/waxing_services/waxing_services.dart';
import 'package:flash_customer/ui/services/widgets/services_widgets.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_bar_widget.dart';
import '../widgets/navigate.dart';

class OurServices extends StatelessWidget {
  const OurServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Other Services'),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 12, vertical: 40),
        child: Padding(
          padding: onlyEdgeInsets(start: 11),
          child: Wrap(
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
          ),
        ),
      ),
    );
  }
}

