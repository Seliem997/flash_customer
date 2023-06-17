import 'package:flash_customer/ui/requests/summaryRequestDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key, required this.requestId})
      : super(key: key);

  final int requestId;
  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    await requestServicesProvider
        .getRequestDetails(requestId: widget.requestId)
        .then((value) => requestServicesProvider.setLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(
      context,
    );
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).requestDetails),
      body: SingleChildScrollView(
        child: requestServicesProvider.isLoading
            ? const DataLoader()
            : Padding(
                padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
                child: SummaryRequestDetails(
                    requestServicesProvider: requestServicesProvider,
                    cameFromOtherServices: requestServicesProvider
                            .detailsRequestData!.services![0].type ==
                        "other"),
              ),
      ),
    );
  }
}
