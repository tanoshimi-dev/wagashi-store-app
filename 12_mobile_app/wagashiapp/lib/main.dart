import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
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

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
      GoRoute(
        path: '/menus',
        builder: (context, state) => const MenuListScreen(),
        //builder: (context, state) => MenuListScreen(),
        routes: [
          GoRoute(
            path: 'detail/:id',
            builder: (context, state) => MenuDetailScreen(
                menuId: int.parse(state.pathParameters['id']!)),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        //builder: (context, state) => MenuListScreen(),
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
//        Provider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => MenusProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => TabMenuStateProvider()),
      ],
      child: DefaultTabController(
        length: 3,
        child: MaterialApp.router(
          title: 'Provider Demo',
          theme: appTheme,
          routerConfig: router(),
        ),
      ),
    );
  }
}
