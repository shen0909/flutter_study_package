// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutterapp/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86/example/privider/provider_shopper/screens/cart.dart';
import 'package:flutterapp/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86/example/privider/provider_shopper/screens/cartalog.dart';
import 'package:flutterapp/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86/example/privider/provider_shopper/screens/login.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'common/theme.dart';
import 'models/cart.dart';
import 'models/cartalog.dart';


void main() {
  runApp(const MyApp());
}

//路由
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
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider is sufficient.
        /*在此示例应用程序中，CatalogModel 永远不会更改，因此一个简单的 Provider 就足够了。*/
        Provider(create: (context) => CatalogModel()),

        //CartModel is implemented as a ChangeNotifier, which calls for the use of ChangeNotifierProvider. Moreover,
        // CartModel depends on CatalogModel, so a ProxyProvider is needed.
        /*CartModel 被实现为 ChangeNotifier，这需要使用 ChangeNotifierProvider。
         而且CartModel依赖于CatalogModel，所以需要一个ProxyProvider。
         ProxyProvider*/
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),//按照要求返回一个CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],

      child:MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        theme: appTheme,
        routeInformationParser: router().routeInformationParser,
        routerDelegate: router().routerDelegate,
        routeInformationProvider: router().routeInformationProvider, // Add this line
      ),
    );
  }
}