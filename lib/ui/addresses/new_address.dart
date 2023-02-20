import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/spaces.dart';
import 'location_dialog.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({Key? key}) : super(key: key);

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/home_mapping.png'),
          Column(
            children: [
              CustomAppBar(
                title: 'My Addresses',
                backgroundColor: Colors.transparent,
              ),
              const Spacer(),
              Padding(
                padding: symmetricEdgeInsets(horizontal: 24),
                child: DefaultButton(
                  text: 'Save Location',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LocationDialog();
                      },
                    );
                  },
                  fontWeight: MyFontWeight.bold,
                  fontSize: 21,
                  height: 48,
                  width: 345,
                ),
              ),
              verticalSpace(50),
            ],
          ),
        ],
      ),
    );
  }
}

