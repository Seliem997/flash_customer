import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
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
                  addressesProvider.addressesDataList.isEmpty
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
                                      itemCount:
                                      addressesProvider.addressesDataList.length,
                                      itemBuilder: (context, index) => Slidable(
                                        key: ValueKey(index),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              flex: 1,
                                              onPressed: (BuildContext context) {
                                                addressesProvider.deleteAddress(
                                                    addressID: addressesProvider
                                                        .addressesDataList[index].id!).then((value) {
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
                                                        .addressesDataList[index]
                                                        .image!,
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
                                                          text: (Intl.getCurrentLocale() == 'ar' ?(addressesProvider
                                                              .addressesDataList[index]
                                                              .locationName ==
                                                              'Location Name' || addressesProvider.addressesDataList[index].locationName == 'Not Selected'
                                                              ? '${addressesProvider.addressesDataList[index].type}'
                                                              : addressesProvider
                                                              .addressesDataList[index]
                                                              .locationName) : addressesProvider
                                                              .addressesDataList[index]
                                                              .locationName ) ??
                                                              '${addressesProvider.addressesDataList[index].type!}${S.of(context).location}',
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
                                                      .addressesDataList[index].type!,
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
                                      ),
                                      separatorBuilder: (context, index) =>
                                          verticalSpace(14),
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
