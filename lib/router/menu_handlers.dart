import 'package:devolucion_modulo/ui/views/traicing_v_view.dart';
import 'package:fluro/fluro.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/side_menu_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/ui/views/admin/approval_view.dart';
import 'package:devolucion_modulo/ui/views/admin/credit_adm_view.dart';
import 'package:devolucion_modulo/ui/views/admin/store_view.dart';
import 'package:devolucion_modulo/ui/views/almacen/request_view_a.dart';
import 'package:devolucion_modulo/ui/views/credit_view.dart';
import 'package:devolucion_modulo/ui/views/login_view.dart';
import 'package:devolucion_modulo/ui/views/menu_return_view.dart';
import 'package:devolucion_modulo/ui/views/menu_view.dart';
import 'package:devolucion_modulo/ui/views/no_acces_page_view.dart';
import 'package:devolucion_modulo/ui/views/resquet_view.dart';
import 'package:devolucion_modulo/ui/views/traicing_view.dart';
import 'package:devolucion_modulo/ui/views/vendedor/request_view_v.dart';
import 'package:provider/provider.dart';

class MenuHandlers {
  static Handler menu = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.menuRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const MenuView();
      } else {
        return const LoginView();
      }
    },
  );
  static Handler returnMenu = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.menuRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "C") {
          return MenuReturnView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );
  static Handler devolucion = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.requestRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "C") {
          return const RequestView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );

  static Handler accesDeneged = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.errorRoute);

      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const NoAccesPageView();
      } else {
        return MenuView();
      }
    },
  );

  static Handler credito = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.creditRoutes);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (params['uid']?.first != null) {
          if (authProvider.cliente!.rolUsr == "C") {
            return CreditView(uid: params['uid']!.first);
          } else {
            return const NoAccesPageView();
          }
        } else {
          return MenuReturnView();
        }
      } else {
        return const LoginView();
      }
    },
  );

  static Handler seguimiento = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.traicingRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "C") {
          return const TraicingView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );

  static Handler approval = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.approvalRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "A") {
          return const ApprovalView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );
  static Handler store = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.storeRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "A") {
          return const StoreView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );
  static Handler almacen = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.alamacenRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "A") {
          return const AlmacenView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );

  static Handler creditAdm = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.creditAdmRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "A") {
          return const CreditAdmView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );

  static Handler vendedor = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.vendedorRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "V") {
          return const RequestViewV();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );
/*   static Handler vendedorProceso = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.vendedorRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "A") {
          return const SearchIg0063View();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  ); */

  static Handler seguimientoVendedor = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.traicingRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.cliente!.rolUsr == "V") {
          return const TraicingVendedorView();
        } else {
          return const NoAccesPageView();
        }
      } else {
        return const LoginView();
      }
    },
  );
}
