import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/theme/colors.dart';
import 'package:lords_palace_app/widgets/coins/coins_bloc/coins_bloc.dart';

class CoinsWidget extends StatefulWidget {
  const CoinsWidget({super.key});

  @override
  State<CoinsWidget> createState() => _CoinsWidgetState();
}

class _CoinsWidgetState extends State<CoinsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoinsBloc()..add(GetCoinsEvent()),
      child: BlocBuilder<CoinsBloc, CoinsState>(
        builder: (context, state) {
          if (state is UpdateCoinsState) {
            return Container(
              padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
              decoration: BoxDecoration(
                  color: AppColors.darkPurple,
                  borderRadius:
                  BorderRadius.all(Radius.circular(100.0))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/images/elements/coin.svg'),
                  SizedBox(width: 5),
                  Text(
                    '${state.coins}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
