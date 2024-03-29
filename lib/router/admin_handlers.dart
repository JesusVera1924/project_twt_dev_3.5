import 'package:fluro/fluro.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/side_menu_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/ui/views/forget_view.dart';
import 'package:devolucion_modulo/ui/views/login_view.dart';
import 'package:devolucion_modulo/ui/views/menu_view.dart';
import 'package:devolucion_modulo/ui/views/register_view.dart';
import 'package:devolucion_modulo/ui/views/rest_pass_view.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.loginRoute);

      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      } else {
        return const MenuView();
      }
    },
  );

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterView();
    } else {
      return const LoginView();
    }
  });
  static Handler forget = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const ForgetView();
    } else {
      return const LoginView();
    }
  });
  static Handler reset = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const ResetPassView();
    } else {
      return const LoginView();
    }
  });
}
