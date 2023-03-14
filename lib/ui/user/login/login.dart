import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/cache_helper.dart';
import '../../../utils/enum/languages.dart';
import '../../../utils/enum/shared_preference_keys.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/eye_widget.dart';
import '../../widgets/phone_text_field.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/spaces.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController countryController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  var phone = '';
  var password = '';

  @override
  void initState() {
    // TODO: implement initState
    countryController = TextEditingController(text: "+20");
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeViewStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          if (Intl.getCurrentLocale() == 'ar') {
                            // MyApp.setLocale(context, const Locale("en"));
                            CacheHelper.saveData(
                                key: CacheKey.language,
                                value: LanguageKey.en.key);
                          } else {
                            // MyApp.setLocale(context, const Locale("ar"));
                            CacheHelper.saveData(
                                key: CacheKey.language,
                                value: LanguageKey.ar.key);
                          }
                        },
                        child: Text(
                          Intl.getCurrentLocale() == 'en' ? "ع" : 'EN',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.secondary,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(2),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 40.w,
                            height: 15.h,
                            child: SvgPicture.asset(
                              'assets/svg/applogo.svg',
                            ),
                          ),
                        ),
                        verticalSpace(5),
                        TextWidget(
                          text: 'letsLogYouIn',
                          color: AppColor.secondary,
                          textSize: 20.sp,
                          isTitle: true,
                        ),
                        verticalSpace(2),
                        Row(
                          children: [
                            TextWidget(
                              text: 'welcomeBack',
                              color: AppColor.secondary,
                              textSize: 13.sp,
                            ),
                            horizontalSpace(2),
                            SvgPicture.asset('assets/svg/hand.svg'),
                          ],
                        ),
                        verticalSpace(4),
                        PhoneTextField(
                            onChanged: (value) {
                              phone = value;
                              _formKey.currentState!.validate();
                            },
                            countryController: countryController,
                            phoneController: phoneController),
                        verticalSpace(2),
                        DefaultFormField(
                          hintText: 'password',
                          controller: passwordController,
                          isPassword: _obscureText,
                          textInputAction: TextInputAction.done,
                          suffixIcon: EyeWidget(onTap: () => changeViewStatus),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'pleaseEnterYourPassword';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            password = value;
                            _formKey.currentState!.validate();
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: TextButton(
                            onPressed: () {},
                            child: TextWidget(
                              text: 'forgotPassword',
                              textSize: 11.sp,
                              color: AppColor.grey,
                            ),
                          ),
                        ),
                        verticalSpace(3.5),
                        DefaultButton(text: 'login', onPressed: () async {}),
                        verticalSpace(12),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RichText(
                            text: TextSpan(
                              text: 'ifYouAreNew',
                              style: TextStyle(
                                  color: AppColor.lightGrey, fontSize: 13.sp),
                              children: [
                                TextSpan(
                                    text: 'createNow',
                                    style: TextStyle(
                                      color: AppColor.secondary,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ],
                            ),
                          ),
                        ),
                        // this is added to force keyboard push up Screen عشان الشاشه تطلع لفوق من ابو اخر
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
