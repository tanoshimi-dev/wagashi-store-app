import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/models/cart.dart';
import '/providers/favorite_provider.dart';
import '/providers/tab_menu_state_provider.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrcodeScanScreen extends StatelessWidget {
  const QrcodeScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      home: ScanPage(),
    );
  }
}

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? _scanResult;
  bool _isFlashOn = false;
  MobileScannerController _scannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      // カメラ使用許可が取得できた場合の処理
    } else if (status.isPermanentlyDenied) {
      // カメラ使用許可が永久に拒否された場合の処理
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner',
            style: Theme.of(context).textTheme.displaySmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // onPressed: () => context.go('/menus/favorites'),
            onPressed: () => context.go('/user_profile'),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            fit: BoxFit.cover,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                setState(() {
                  _scanResult = barcode.rawValue;
                });
              }
            },
          ),
          if (_scanResult != null)
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                'Scan Result: $_scanResult',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          // QRコード + user_id , 成功するとスタンプを押してスタンプ画面に遷移
        ],
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
