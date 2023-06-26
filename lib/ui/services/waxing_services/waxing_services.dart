import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../widgets/custom_bar_widget.dart';
import '../widgets/other_services_widgets.dart';

class WaxingServices extends StatelessWidget {
  const WaxingServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).waxingServices),
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
