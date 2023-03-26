import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';

class ImageEditable extends StatelessWidget {
  const ImageEditable({
    Key? key,
    required this.imageUrl,
    this.onTap,
    this.height,
    this.width,
    this.showEditIcon = false,
    this.isVehicle = false,
    this.bottomPositioned,
  }) : super(key: key);
  final String imageUrl;
  final bool showEditIcon;
  final bool isVehicle;
  final double? height, width, bottomPositioned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Container(
          //   width: width != null ? (width! / screenWidth) * 100.w : null,
          //   height: height != null
          //       ? (height! / screenHeight) * 100.h // deduct safe area space
          //       : null,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: imageUrl.isEmpty
          //           ? const AssetImage(
          //               'assets/images/profile.png',
          //             )
          //           : CachedNetworkImageProvider(imageUrl) as ImageProvider,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          const CircleAvatar(
            backgroundColor: Color.fromRGBO(0, 107, 182, 0.53),
            radius: 55,
            child: CircleAvatar(
              radius: 49,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
          Visibility(
            visible: showEditIcon,
            child: Positioned(
              bottom: bottomPositioned ?? 0.5.h,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: SvgPicture.asset('assets/svg/edit.svg', height: 3.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
