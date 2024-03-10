import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../generated/l10n.dart';
import '../../providers/addresses_provider.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/snack_bars.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';
import 'new_address.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({Key? key}) : super(key: key);

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  final GlobalKey listAddressKey= GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([ listAddressKey,])
    );
    super.initState();
  }



  void loadData() async {
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context, listen: false);

    await addressesProvider
        .getAddresses()
        .then((value) => addressesProvider.setLoading(false));
    
  }

  @override
  Widget build(BuildContext context) {
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: S.of(context).myAddresses,
      ),
      body: addressesProvider.isLoading
          ? const DataLoader()
          : Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: Column(
                children: [
                  addressesProvider.allAddressesDataList.isEmpty
                      ? Expanded(
                          child: Center(
                              child: TextWidget(
                                  text: S.of(context).thereIsNoAddressYet)))
                      : Expanded(
                              child: Showcase(
                                key: listAddressKey,
                                description: S.of(context).swipeAnyAddressLeftToDelete,
                                child: Padding(
                                  padding: symmetricEdgeInsets(vertical: 30),
                                  child: ShowCaseWidget(builder: Builder(builder: (context){
                                    return ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: addressesProvider.allAddressesDataList.length + 1,
                                      itemBuilder: (context, index) {
                                        if(index < addressesProvider.allAddressesDataList.length){
                                          return Slidable(
                                            key: ValueKey(index),
                                            endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  flex: 1,
                                                  onPressed: (BuildContext context) {
                                                    addressesProvider.deleteAddress(
                                                        addressID: addressesProvider
                                                            .allAddressesDataList[index].id!).then((value) {
                                                      if (value.status == Status.success) {
                                                        CustomSnackBars.successSnackBar(
                                                            _scaffoldKey.currentContext!, '${value.message}');
                                                      } else {
                                                        CustomSnackBars.failureSnackBar(_scaffoldKey.currentContext!, '${value.message}');
                                                      }
                                                    });
                                                  },
                                                  backgroundColor: const Color(0xFFE74A2A),
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete_forever_outlined,
                                                  label: S.of(context).delete,
                                                ),
                                              ],
                                            ),
                                            child: CustomContainer(
                                              height: 64,
                                              width: 345,
                                              backgroundColor: const Color(0xFFE6EEFB),
                                              child: Padding(
                                                padding: symmetricEdgeInsets(
                                                    vertical: 7, horizontal: 7),
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
                                                        addressesProvider
                                                            .allAddressesDataList[index]
                                                            .image != null ? addressesProvider
                                                            .allAddressesDataList[index]
                                                            .image! : 'https://cdn.salla.sa/OnAOY/tD8aFkV8PRKh2ryXbFwigSEa7DAlKISoYXwwE11s.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    horizontalSpace(12),
                                                    Expanded(
                                                      child: CustomSizedBox(
                                                        width: 157,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceAround,
                                                          children: [
                                                            TextWidget(
                                                              text:
                                                              addressesProvider
                                                                  .allAddressesDataList[index]
                                                                  .locationName ==
                                                                  'Location Name' || addressesProvider.allAddressesDataList[index].locationName == 'Not Selected'
                                                                  ? '${S.of(context).location} ${addressesProvider.allAddressesDataList[index].type!}'
                                                                  : addressesProvider
                                                                  .allAddressesDataList[index]
                                                                  .locationName!,
                                                              maxLines: 2,
                                                              fontWeight: MyFontWeight.medium,
                                                              textSize: MyFontSize.size10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    horizontalSpace(20),
                                                    DefaultButton(
                                                      text: addressesProvider
                                                          .allAddressesDataList[index].type!,
                                                      fontWeight: MyFontWeight.semiBold,
                                                      fontSize: MyFontSize.size9,
                                                      onPressed: () {},
                                                      backgroundColor:
                                                      const Color(0xFF66C0FF),
                                                      height: 25,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }else{
                                          return addressesProvider.currentPage >= addressesProvider.lastPage ? SizedBox() : Padding(
                                            padding: symmetricEdgeInsets(horizontal: 50),
                                            child: DefaultButton(
                                              text: S.of(context).showMoreAddresses,
                                              textColor: Colors.black,
                                              backgroundColor: const Color(0xFFE6EEFB),
                                              onPressed: (){
                                                addressesProvider.getAddresses(page: (1+addressesProvider.currentPage)).then((value) {
                                                  addressesProvider.setLoading(false);
                                                });
                                              },
                                            ),
                                          );
/*
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                            child: CustomContainer(
                                              height: 40,
                                              width: double.infinity,
                                              backgroundColor: AppColor.lightBabyBlue,
                                              backgroundColorDark: AppColor.lightGrey,
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                              child: ListView.separated(
                                                scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) => CustomContainer(
                                                      height: 30,
                                                      width: 35,
                                                      borderRadius: BorderRadius.circular(2),
                                                      borderColor: Colors.black,
                                                    borderColorDark: Colors.black,
                                                    child: Center(child: TextWidget(text: '${index+1}'),),
                                                    onTap: (){
                                                      addressesProvider.getAddresses(page: index+1).then((value) {
                                                        addressesProvider.setLoading(false);
                                                      });
                                                    },
                                                  ),
                                                  separatorBuilder: (context, index) => horizontalSpace(20),
                                                  itemCount: addressesProvider.lastPage ),
                                            ),
                                          );
*/
                                        }
                                      },
                                      separatorBuilder: (context, index) {
                                        if(index == addressesProvider.allAddressesDataList.length-1){
                                          return verticalSpace(50);
                                        }else{
                                          return verticalSpace(14);
                                        }
                                      },
                                    );
                                  })),
                                ),
                              ),
                            ),
                  Padding(
                    padding: symmetricEdgeInsets(horizontal: 24),
                    child: DefaultButton(
                      text: S.of(context).addNewAddress,
                      onPressed: () {
                        navigateTo(context, const NewAddress());
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
