import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/models/cart.dart';
import '/providers/favorite_provider.dart';
import '/providers/tab_menu_state_provider.dart';

class StampScreen extends StatelessWidget {
  const StampScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var tabMenuStateProvider = context.watch<TabMenuStateProvider>();
    // final int _currentIndex = tabMenuStateProvider.tabMenuIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stamp', style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // onPressed: () => context.go('/menus/favorites'),
            onPressed: () => context.go('/user_profile'),
          ),
        ],
      ),
      body: Container(
        color: Colors.amber[100],
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _StampGrid(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          print('home screen tab index $index');
          // getMenus();
          if (index == 0) {
            print('home $index');
            context.go('/home');
          } else if (index == 1) {
            print('stamp $index');
            context.go('/stamp');
          } else if (index == 2) {
            print('qrcode_scan $index');
            context.go('/qrcode_scan');
          } else {
            context.go('/home');
          }
        },
        selectedIndex: 0,
        // 下のプロパティで背景色を設定できます。
        // backgroundColor: Colors.black,
        animationDuration: const Duration(seconds: 10),
        elevation: 10,
        // height: 100,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home), label: 'ホーム', tooltip: "tooltip1"),
          NavigationDestination(
              icon: Icon(Icons.menu_book), label: 'お菓子', tooltip: "tooltip2"),
          NavigationDestination(
              icon: Icon(Icons.search), label: '検索', tooltip: "tooltip4"),
          NavigationDestination(
              icon: Icon(Icons.card_giftcard),
              label: 'スタンプ',
              tooltip: "tooltip5"),
        ],
      ),
    );
  }
}

class _StampGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    // var favoriteProvider = context.watch<FavoriteProvider>();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
        childAspectRatio: 3 / 2, // Aspect ratio of each item
      ),
      // itemCount: favoriteProvider.favoritesMenu.length,
      itemCount: 9,
      itemBuilder: (context, index) => GridTile(
        header: GridTileBar(
          leading: const Icon(Icons.done),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              // favoriteProvider.remove(favoriteProvider.favoritesMenu[index]);
            },
          ),
        ),
        child: Center(
          child: Text(
            // favoriteProvider.favoritesMenu[index].name,
            'Menu Name',
            style: itemNameStyle,
          ),
        ),
      ),
    );
  }
}
