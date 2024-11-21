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
    var tabMenuStateProvider = context.watch<TabMenuStateProvider>();
    final int _currentIndex = tabMenuStateProvider.tabMenuIndex;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Text('FAVORITES', style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
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
            _PriceTotal()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Favorites',
          ),
        ],
        // Set the current index
        currentIndex: _currentIndex,
        onTap: (int index) {
          tabMenuStateProvider.setTabMenuIndex(index);
          print('Add your code here');

          if (index == 0) {
            context.go('/menus');
          } else {
            context.replace('/menus/favorites');
          }
        },
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

class _PriceTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Another way to listen to a model's change is to include
            // the Consumer widget. This widget will automatically listen
            // to CartModel and rerun its builder on every change.
            //
            // The important thing is that it will not rebuild
            // the rest of the widgets in this build method.
            Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, child) =>
                    Text('\$${favoriteProvider.totalPrice}', style: hugeStyle)),
            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}