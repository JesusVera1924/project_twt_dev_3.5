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

      if (authProvider.authStatus == AuthStatus.notAuthenticated)
        return LoginView();
      else
        return MenuView();
    },
  );

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return RegisterView();
    else
      return LoginView();
  });
  static Handler forget = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return ForgetView();
    else
      return LoginView();
  });
  static Handler reset = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return ResetPassView();
    else
      return LoginView();
  });
}
