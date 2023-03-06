import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    this.width,
    this.height,
    this.radiusCircular = 10,
    this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.backgroundColor,
    this.onTap,
    this.borderColor = Colors.transparent,
    this.image,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.isCircle = false,
  }) : super(key: key);

  final double? width, height ;
  final double radiusCircular;
  final Widget? child;
  final EdgeInsetsGeometry? padding, margin;
  final Color? backgroundColor, borderColor;
  final AlignmentGeometry? alignment;
  final GestureTapCallback? onTap;
  final DecorationImage? image;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width != null ? (width! / screenWidth) * 100.w : null,
        height: height != null
            ? (height! / screenHeight) * 100.h // deduct safe area space
            : null,
        clipBehavior: clipBehavior,
        padding: padding ?? EdgeInsets.zero,
        alignment: alignment,
        margin: margin ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
            image: image,
            color: backgroundColor ?? Colors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(radiusCircular),
            border: Border.all(color: borderColor!),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            /*boxShadow: const [
            BoxShadow(
              color: AppColor.tertiary,
              offset: Offset(
                1.0,
                1.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 0.4,
            ),
          ],*/
            ),
        child: child,
      ),
    );
  }
}

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({Key? key, this.width, this.height, required this.child, this.onTap})
      : super(key: key);
  final double? width, height;
  final GestureTapCallback? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width != null ? (width! / screenWidth) * 100.w : null,
        height: height != null
            ? (height! / screenHeight) * 100.h // deduct safe area space
            : null,
        child: child,
      ),
    );
  }
}
