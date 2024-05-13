import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/router/router.dart';
import 'package:lords_palace_app/theme/colors.dart';

@RoutePage()
class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/settings/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.router.push(SettingsListRoute());
                      },
                      child: SvgPicture.asset(
                          'assets/images/elements/back-btn.svg'),
                    ),
                    Image.asset('assets/images/settings/rules-title.png'),
                    SizedBox(width: 70),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  'You must collect a certain number of combinations of 3 or more elements in a row within a set time. Each successful combination gives you the opportunity to earn coins.  Coins can be spent on additional bonuses, such as free moves and extra time.  You can also buy diamonds, which will be spent during two unsuccessful attempts in a row.  The game will be over and you will lose when you run out of time or diamonds and did not have time to collect the required number of combinations.',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
