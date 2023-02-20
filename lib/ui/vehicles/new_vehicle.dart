import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/colors.dart';
import 'package:flutter/material.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({Key? key}) : super(key: key);

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String? selectedItem = 'Item 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Vehicle Info',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetricEdgeInsets(horizontal: 10),
          child: Column(
            children: [
              TextWidget(
                text: 'Select',
              ),
              verticalSpace(2),
              CustomSizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: AppColor.babyBlue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color: AppColor.babyBlue,),
                    )
                  ),
                    items: items.map((item) {
                      return DropdownMenuItem<String>(
                        child: TextWidget(text: item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() {
                        selectedItem = item;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
