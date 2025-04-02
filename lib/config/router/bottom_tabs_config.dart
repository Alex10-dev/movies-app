
import 'package:flutter/material.dart';
import 'package:movies/config/router/app_bottom_tab.dart';
import 'package:movies/presentation/Views/movies/home_view.dart';
import 'package:movies/presentation/Views/movies/search_view.dart';

List<AppBottomTab> appTabs = [
  const AppBottomTab(index: 0, route: 'explore', icon: Icons.home_outlined, label: 'Home', view: HomeView()),
  const AppBottomTab(index: 1, route: 'search', icon: Icons.search_outlined, label: 'Search', view: SearchView()),
  AppBottomTab(index: 2, route: 'tickets', icon: Icons.wallet_outlined, label: 'Tickets', view: Container(color: Colors.amber,)),
  AppBottomTab(index: 3, route: 'favorites', icon: Icons.favorite_border_outlined, label: 'Favorites', view: Container(color: Colors.black,)),
];