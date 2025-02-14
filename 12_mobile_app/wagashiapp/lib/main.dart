import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '/common/theme.dart';
import '/providers/menus_provider.dart';
import '/providers/favorite_provider.dart';
import '/providers/tab_menu_state_provider.dart';
import '/screens/cart.dart';
import '/screens/catalog.dart';
import '/screens/favorites_screen.dart';
import '/screens/menu_detail_screen.dart';
import '/screens/menu_list_screen.dart';
import '/screens/home_screen.dart';
import '/screens/login.dart';
import '/screens/login_screen.dart';
import '/screens/user_profile_screen.dart';
import '/screens/stamp_screen.dart';
import '/screens/qrcode_scan_screen.dart';

import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          final token = snapshot.data;
          final GoRouter _router = GoRouter(
            initialLocation: token == null ? '/' : '/home',
            //initialLocation: '/',
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => LoginScreen(),
              ),
              GoRoute(
                path: '/home',
                builder: (context, state) => HomeScreen(),
              ),
              GoRoute(
                path: '/stamp',
                builder: (context, state) => StampScreen(),
              ),
              GoRoute(
                path: '/qrcode_scan',
                builder: (context, state) => const QrcodeScanScreen(),
                //builder: (context, state) => MenuListScreen(),
              ),
              GoRoute(
                path: '/user_profile',
                builder: (context, state) => UserProfileScreen(),
              ),
            ],
          );

          return MaterialApp.router(
            routerConfig: _router,
            title: 'Wagashi Store App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        }
      },
    );
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
