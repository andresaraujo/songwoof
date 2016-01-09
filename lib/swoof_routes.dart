library songwoof.routes;

import 'package:angular2/router.dart';
import 'package:songwoof/discover/discover.dart';
import 'package:songwoof/login/login.dart';
import 'package:songwoof/home/home.dart';
import 'package:songwoof/favorites/favorites.dart';

const List<Route> SWOOF_ROUTES = const [
  const Route(
      path: '/home',
      name: 'Home',
      component: HomeComponent,
      useAsDefault: true),
  const Route(
      path: '/discover', name: 'Discover', component: DiscoverComponent),
  const Route(path: '/login', name: 'Login', component: LoginComponent),
  const Route(
      path: '/favorites', name: 'Favorites', component: FavoritesComponent)
];
