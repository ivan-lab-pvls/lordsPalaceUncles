import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/router/router.dart';
import 'package:lords_palace_app/theme/colors.dart';
import 'package:lords_palace_app/widgets/action_button_widget.dart';
import 'package:lords_palace_app/widgets/coins/coins.dart';
import 'package:lords_palace_app/widgets/daily_reward/daily_reward.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home/home-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/home/title.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CoinsWidget(),
                    GestureDetector(
                        onTap: () {
                          context.router.push(SettingsListRoute());
                        },
                        child: SvgPicture.asset(
                            'assets/images/elements/settings-button.svg')),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset('assets/images/home/1.png'),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset('assets/images/home/2.png'),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset('assets/images/home/3.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: AppColors.lightPurple,
                    dotColor: AppColors.white50,
                    dotHeight: 3,
                    dotWidth: 37,
                    radius: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _openDialog,
                child: Container(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                          'assets/images/elements/daily-reward-button.svg'),
                      SizedBox(height: 5),
                      Text(
                        'Daily Reward',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
              ActionButtonWidget(
                text: 'Start',
                onTap: () {
                  switch (pageIndex) {
                    case 0:
                      context.router.push(MagicKitchenRoute());
                    case 1:
                      context.router.push(MysteriousMineRoute());
                    case 2:
                      context.router.push(ArchaeologistsRoomRoute());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return DailyReward();
      },
    );
  }
}
