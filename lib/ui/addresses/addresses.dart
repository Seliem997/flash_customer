import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/addresses_provider.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import 'new_address.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({Key? key}) : super(key: key);

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final AddressesProvider addressesProvider=Provider.of<AddressesProvider>(context, listen: false);

    addressesProvider.getAddresses();
  }
  @override
  Widget build(BuildContext context) {
    final AddressesProvider addressesProvider=Provider.of<AddressesProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Addresses',
      ),
      body: addressesProvider.addressesDataList.isEmpty
          ? const DataLoader()
          : Padding(
        padding: symmetricEdgeInsets(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: symmetricEdgeInsets(vertical: 30),
                child: ListView.separated(
                  itemCount: addressesProvider.addressesDataList.length,
                  itemBuilder: (context, index) => CustomContainer(
                    height: 64,
                    width: 345,
                    backgroundColor: const Color(0xFFE6EEFB),
                    child: Padding(
                      padding:
                      symmetricEdgeInsets(vertical: 7, horizontal: 7),
                      child: Row(
                        children: [
                          CustomContainer(
                            width: 50,
                            height: 50,
                            radiusCircular: 3,
                            padding: EdgeInsets.zero,
                            clipBehavior: Clip.hardEdge,
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              addressesProvider.addressesDataList[index].image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          horizontalSpace(12),
                          CustomSizedBox(
                            width: 157,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWidget(
                                  text:
                                  addressesProvider.addressesDataList[index].locationName!,
                                  maxLines: 2,
                                  fontWeight: MyFontWeight.medium,
                                  textSize: MyFontSize.size10,
                                ),
                                // TextWidget(
                                //   text: 'Tarut 32626',
                                //   fontWeight: MyFontWeight.medium,
                                //   textSize: MyFontSize.size10,
                                //   maxLines: 1,
                                // ),
                              ],
                            ),
                          ),
                          horizontalSpace(30),
                          DefaultButton(
                            text: addressesProvider.addressesDataList[index].type!,
                            fontWeight: MyFontWeight.semiBold,
                            fontSize: MyFontSize.size9,
                            onPressed: () {},
                            backgroundColor: const Color(0xFF66C0FF),
                            width: 64,
                            height: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => verticalSpace(14),
                ),
              ),
            ),
            Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: DefaultButton(
                text: 'Add new address',
                onPressed: () {
                  navigateTo(context, NewAddress());
                },
                fontWeight: MyFontWeight.bold,
                fontSize: 21,
                height: 48,
                width: 345,
              ),
            ),
            verticalSpace(50)
          ],
        ),
      ),
    );
  }
}
