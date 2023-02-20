import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_bar_widget.dart';
import '../widgets/services_widgets.dart';

class WaxingServices extends StatelessWidget {
  const WaxingServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Waxing Services'),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 40),
        child: Column(
          children: const [
            WaxingServicesItem(
              title: 'Outside Wax',
              imageName: 'assets/images/outside_wax.png',
              serviceValue: '500 SR',
            ),
            WaxingServicesItem(
              title: 'Lorem ipsum',
              imageName: 'assets/images/waxing_cleaning.png',
              serviceValue: '400 SR',
            ),
            WaxingServicesItem(
              title: 'Lorem ipsum',
              imageName: 'assets/images/waxing_cleaning.png',
              serviceValue: '300 SR',
            ),
            WaxingServicesItem(
              title: 'Lorem ipsum',
              imageName: 'assets/images/waxing_cleaning.png',
              serviceValue: '650 SR',
            ),
          ],
        ),
      ),
    );
  }
}
