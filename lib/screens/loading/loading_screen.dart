import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/router/router.dart';
import 'package:lords_palace_app/theme/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

@RoutePage()
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/loading/logo.svg'),
              SizedBox(height: 50),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                child: LinearPercentIndicator(
                    animation: true,
                    animationDuration: 2000,
                    lineHeight: 4.0,
                    percent: 1.0,
                    barRadius: Radius.circular(300),
                    backgroundColor: Color(0xFF8C0DF2),
                    progressColor: Colors.white,
                    onAnimationEnd: () {
                      context.router.push(HomeRoute());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
