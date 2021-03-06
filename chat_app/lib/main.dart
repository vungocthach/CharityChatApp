import 'package:chat_app/configs/colorconfig.dart';
import 'package:chat_app/helper/network/socket_service.dart';
import 'package:chat_app/presentation/bloc/active_user/active_user_bloc.dart';
import 'package:chat_app/presentation/bloc/chat_overview/chat_overview_bloc.dart';
import 'package:chat_app/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/presentation/bloc/new_message/new_message_bloc.dart';
import 'package:chat_app/presentation/bloc/root_app/root_app_bloc.dart';
import 'package:chat_app/presentation/pages/login_page/login_page.dart';
import 'package:chat_app/presentation/rootapp.dart';
import 'package:chat_app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dependencies_injection.dart' as di;
import 'dependencies_injection.dart';
import 'presentation/bloc/main_bloc/main_bloc_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  // HttpOverrides.global = MyHttpOverrides();
  await initMain();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => MainBlocBloc(sl())..add(MainBlocCheck()),
      ),
      BlocProvider(
        create: (context) => RootAppBloc(),
      ),
    ],

    child: const MyApp(),
  ));
}

Future<void> initMain() async {
  await di.init();
  getPackage();
  final socket = sl<SocketService>();
  socket.connect();
  socket.addEventReconnect((data) async {
    final token = await sl<LocalStorageService>().getToken();
    socket.emit('online', token);
  });
}

 void getPackage() async {
    PackageInfo? packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo!.appName;
    String packageName = packageInfo!.packageName;
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;
    print("App Name : ${appName}, App Package Name: ${packageName },App Version: ${version}, App build Number: ${buildNumber}");
  }

// Future<void> testLogin() async {
//   final storage = sl<LocalStorageService>();
//   final socket = sl<SocketService>();
//   try {
//     final mockData = await storage.getMockUserData(1);
//     final token = await sl<IAuthenticateRepository>()
//         .logIn(mockData['email'], mockData['password']);
//   } catch (e) {
//     print(e);
//   }
// }

class MyApp extends StatelessWidget {
  final bool isChangeAccount;
  const MyApp({Key? key, this.isChangeAccount = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isChangeAccount) {
      BlocProvider.of<MainBlocBloc>(context).add(MainBlocCheck());
    }
    sl<SocketService>().addEventListener('request-login', (_) {
      BlocProvider.of<MainBlocBloc>(context).add(MainBlocLogout());
    });

    return ScreenUtilInit(
        designSize: const Size(360, 780),
        minTextAdapt: true,
        builder: () => BlocBuilder<MainBlocBloc, MainBlocState>(
              builder: (context, state) {
                if (state is MainBlocAlreadyLogin) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(primaryColor: cwColorMain),
                    home: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => ChatOverviewBloc(sl()),
                        ),
                        BlocProvider(
                          create: (context) => ActiveUserBloc(sl()),
                        ),
                        BlocProvider(
                          create: (context) => NewMessageBloc(sl(), sl()),
                        ),
                      ],
                      child: const RootApp(),
                    ),
                  );
                } else {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(primaryColor: cwColorMain),
                    home: BlocProvider(
                      create: (context) => LoginBloc(sl()),
                      child: const LoginPage(),
                    ),
                  );
                }
              },
            ));
  }
}
