import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/user_provider.dart';
import '../home/home_screen.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';
import '../widgets/spaces.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({Key? key}) : super(key: key);

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> with TickerProviderStateMixin{
  late GifController _controller;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    _controller = GifController(vsync: this);
    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void loadData() async {
    final UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    await Future.delayed(const Duration(seconds: 3));
    await userProvider.getUserData().then((value) => navigateAndFinish(
      context, const HomeScreen(),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomSizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controller.isCompleted
                  ? const CustomContainer(
                  height: 180,
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png')))
                  : Gif(
                height: 400,
                image:
                const AssetImage('assets/images/logo.png'),
                controller:
                _controller, // if duration and fps is null, original gif fps will be used.
                autostart: Autostart.once,
              ),
              verticalSpace(20),
              Visibility(
                visible: _controller.isCompleted,
                child: const SizedBox(
                  height: 20,
                  width: 20,
                  child: DataLoader(useExpand: false),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
