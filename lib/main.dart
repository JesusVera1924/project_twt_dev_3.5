import 'package:devolucion_modulo/provider/almacen_provider.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/banner_menu_provider.dart';
import 'package:devolucion_modulo/provider/credit_provider.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/provider/mg0031_provider.dart';
import 'package:devolucion_modulo/provider/return_provider.dart';
import 'package:devolucion_modulo/provider/side_menu_provider.dart';
import 'package:devolucion_modulo/provider/transport_provider.dart';
import 'package:devolucion_modulo/provider/vendedor_dialog_provider.dart';
import 'package:devolucion_modulo/provider/vendedor_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/layouts/auth/auth_layouts.dart';
import 'package:devolucion_modulo/ui/layouts/menu/menu_layout.dart';
import 'package:devolucion_modulo/ui/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => ReturnProvider()),
        ChangeNotifierProvider(create: (_) => AlmacenProvider()),
        ChangeNotifierProvider(create: (_) => VendedorProvider()),
        ChangeNotifierProvider(create: (_) => VendedorDialogProvider()),
        ChangeNotifierProvider(create: (_) => ItemsIg0063()),
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
        ChangeNotifierProvider(create: (_) => TrasnsportProvider()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => BannerMenuProvider()),
        ChangeNotifierProvider(create: (_) => CreditProvider()),
        ChangeNotifierProvider(create: (_) => CreditsProvider()),
        ChangeNotifierProvider(create: (_) => Mg0031Provider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenido al Sistema',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return SplashLayout();
        }
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return MenuLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
        ),
      ),
    );
  }
}
