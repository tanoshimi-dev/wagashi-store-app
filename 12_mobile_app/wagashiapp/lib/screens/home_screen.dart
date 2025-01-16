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
            // onPressed: () => context.go('/menus/favorites'),
            onPressed: () => context.go('/user_profile'),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        Expanded(
            child: Scrollbar(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  primary: false,
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                        color: Colors.blueGrey,
                      ),
                    ),
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
                    SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                        color: Colors.blueGrey,
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
                    SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                        color: Colors.blueGrey,
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
