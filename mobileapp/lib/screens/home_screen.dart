// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '/providers/menus_provider.dart';
import '/providers/favorite_provider.dart';
import '/providers/tab_menu_state_provider.dart';
import '/models/menu.dart';
import '/models/menus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tabMenuStateProvider = context.watch<TabMenuStateProvider>();
    final int _currentIndex = tabMenuStateProvider.tabMenuIndex;

    var menusProvider = context.read<MenusProvider>();
    //late Future<List<Menu>>? menuList = getMenus(context);
    // print('menuList  ${menusProvider.menus.length}');
    // if (menusProvider.menus.length == 0) {
    //   menusProvider.setMenus(menuList);
    //   print('DB検索しました ${menusProvider.menus.length}');
    // }

    final ScrollController _scrollController = ScrollController();
    final ScrollController _scrollController2 = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/menus/favorites'),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              // Perform the search operation
            },
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: SizedBox(
        //       height: 200, // Set this to the desired height
        //       child: Scrollbar(
        //         controller: _scrollController,
        //         thumbVisibility: true,
        //         child: ListView(
        //           controller: _scrollController,
        //           scrollDirection: Axis.horizontal,
        //           children: <Widget>[
        //             Container(
        //               width: 200, // Set this to the desired width of each item
        //               color: Colors.red,
        //               child: const Text('Item 1'),
        //             ),
        //             Container(
        //               width: 200, // Set this to the desired width of each item
        //               color: Colors.blue,
        //               child: const Text('Item 2'),
        //             ),
        //             Container(
        //               width: 200, // Set this to the desired width of each item
        //               color: Colors.indigo,
        //               child: const Text('Item 1'),
        //             ),
        //             Container(
        //               width: 200, // Set this to the desired width of each item
        //               color: Colors.green,
        //               child: const Text('Item 2'),
        //             ),

        //             // Add more containers for more items
        //           ],
        //         ),
        //       )),
        // ),
        Expanded(
            child: Scrollbar(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.green[100],
                            child:
                                const Text("He'd have you all unravel at the"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.green[200],
                            child: const Text('Heed not the rabble'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.green[300],
                            child: const Text('Sound of screams but the'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.green[400],
                            child: const Text('Who scream'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.green[500],
                            child: const Text('Revolution is coming...'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.green[600],
                            child: const Text('Revolution, they...'),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(
                            height: 200, // Set this to the desired height
                            child: Scrollbar(
                              controller: _scrollController2,
                              thumbVisibility: true,
                              child: ListView(
                                controller: _scrollController2,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    width:
                                        200, // Set this to the desired width of each item
                                    color: Colors.red,
                                    child: const Text('Item 1'),
                                  ),
                                  Container(
                                    width:
                                        200, // Set this to the desired width of each item
                                    color: Colors.blue,
                                    child: const Text('Item 2'),
                                  ),
                                  Container(
                                    width:
                                        200, // Set this to the desired width of each item
                                    color: Colors.indigo,
                                    child: const Text('Item 1'),
                                  ),
                                  Container(
                                    width:
                                        200, // Set this to the desired width of each item
                                    color: Colors.green,
                                    child: const Text('Item 2'),
                                  ),

                                  // Add more containers for more items
                                ],
                              ),
                            )),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverFixedExtentList(
                        itemExtent: 50.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.center,
                              color: Colors.lightBlue[100 * (index % 9)],
                              child: Text('List Item $index'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ))),
      ]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          context.go('/home');
        },
        selectedIndex: _currentIndex,
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

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('MENU', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => context.go('/menus/favorites'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final Menu menu;
  const _MyListItem({required this.menu});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: LimitedBox(
        maxHeight: 24,
        child: InkWell(
          onTap: () => context.go('/menus/detail/${menu.menuId.toString()}'),
          child: Row(
            children: [
              Text(menu.menuId.toString()),
              const SizedBox(width: 24),
              Expanded(
                child:
                    Text(menu.name, style: textTheme?.copyWith(fontSize: 16.0)),
              ),
              const SizedBox(width: 6),
              _FavIcon(menu: menu),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavIcon extends StatelessWidget {
  final Menu menu;

  const _FavIcon({required this.menu});

  @override
  Widget build(BuildContext context) {
    var isFavorite = context.select<FavoriteProvider, bool>(
      (favoriteProvider) => favoriteProvider.favoritesMenu.contains(menu),
    );

    return isFavorite
        ? Icon(
            Icons.check,
            color: Colors.grey, // Change the color of the icon
            size: 24.0, // Change the size of the icon
            semanticLabel: 'ADDED',
          )
        : Text('');
  }
}

// DBからメニュー情報を取得する
Future<List<Menu>> getMenus(BuildContext context) async {
  // Add a return statement at the end
  var menusProvider = context.read<MenusProvider>();
  print('getMenus 現在数 ${menusProvider.menus.length}');

  if (menusProvider.menus.length > 0) {
    print('DB検索しません ${menusProvider.menus.length}');
    return menusProvider.menus;
  }

  try {
    // エミュレーターから（ローカルPC内の）dockerコンテナへのアドレスは10.0.2.2となる
    final response =
        await http.get(Uri.parse('http://10.0.2.2:15011/api/menus')).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw TimeoutException('The connection has timed out!');
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      // print(data);
      // print(data.length);
      List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(data);

      // Now you can iterate over dataList
      for (var menu in dataList) {
        //print(item);
        // item.forEach((key, value) {
        //   print('Key: $key, Value: $value');
        // });
        print('item message=${menu['id']} number=${menu['name']}');
      }

      List<Menu> menuList = dataList.map((menu) {
        return Menu(
          menuId: menu['id'],
          name: menu['name'],
          price: menu['price'] ?? 0,
          description: menu['description'] ?? 'No description',
        );
      }).toList();
      return menuList;

      //return dataList;
    } else {
      // If the server returns an unexpected response, throw an error.
      throw Exception('Unexpected response from the server!');
    }
  } on TimeoutException catch (e) {
    // Handle the timeout exception
    print(e.message);
    return [];
  } catch (e) {
    // Handle any other exceptions
    print(e);
    return [];
  }
  return [];
}
