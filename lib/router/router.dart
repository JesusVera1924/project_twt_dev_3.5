import 'package:fluro/fluro.dart';
import 'package:devolucion_modulo/router/admin_handlers.dart';
import 'package:devolucion_modulo/router/menu_handlers.dart';
import 'package:devolucion_modulo/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  //path
  static String rootRoute = '/';

  //Auth
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';
  static String forgetRoute = '/auth/forget';
  static String resetRoute = '/auth/reset';

  //menu
  static String menuRoute = '/menu';
  static String menuReturnRoute = '/menu/return';

  //Forms is user
  static String creditRoutes = '/menu/credito/:uid';
  static String requestRoute = '/menu/devolucion';
  static String errorRoute = '/menu/accesDeneged';
  static String traicingRoute = '/menu/seguimiento';
  //Admin
  static String approvalRoute = '/menu/approval';
  static String storeRoute = '/menu/store';
  static String creditAdmRoute = '/menu/credit';

  // Almacen
  static String alamacenRoute = '/menu/almacen';
  // Vendedor
  static String vendedorRoute = '/menu/vendedor';
  //static String vendedorProcesoRoute = '/menu/proceso';
  static String chatProcesoRoute = '/menu/chatbot';
  static String traicingVendedorRoute = '/menu/vendedor/seguimiento';

  static void configureRoutes() {
    //login
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);
    router.define(forgetRoute,
        handler: AdminHandlers.forget, transitionType: TransitionType.none);
    router.define(resetRoute,
        handler: AdminHandlers.reset, transitionType: TransitionType.none);

    //menu
    router.define(menuRoute,
        handler: MenuHandlers.menu, transitionType: TransitionType.fadeIn);
    router.define(menuReturnRoute,
        handler: MenuHandlers.returnMenu,
        transitionType: TransitionType.fadeIn);
    router.define(creditRoutes,
        handler: MenuHandlers.credito, transitionType: TransitionType.fadeIn);
    router.define(requestRoute,
        handler: MenuHandlers.devolucion,
        transitionType: TransitionType.fadeIn);

    //devolucion por segmento
    router.define(errorRoute,
        handler: MenuHandlers.accesDeneged,
        transitionType: TransitionType.fadeIn);

    router.define(traicingRoute,
        handler: MenuHandlers.seguimiento,
        transitionType: TransitionType.fadeIn);

    //Admin
    router.define(approvalRoute,
        handler: MenuHandlers.approval, transitionType: TransitionType.fadeIn);

    router.define(storeRoute,
        handler: MenuHandlers.store, transitionType: TransitionType.fadeIn);

    router.define(creditAdmRoute,
        handler: MenuHandlers.creditAdm, transitionType: TransitionType.fadeIn);

    //Almacen
    router.define(alamacenRoute,
        handler: MenuHandlers.almacen, transitionType: TransitionType.fadeIn);
    //Vendedor
    router.define(vendedorRoute,
        handler: MenuHandlers.vendedor, transitionType: TransitionType.fadeIn);

    /*  router.define(vendedorProcesoRoute,
        handler: MenuHandlers.vendedorProceso,
        transitionType: TransitionType.fadeIn); */

    router.define(traicingVendedorRoute,
        handler: MenuHandlers.seguimientoVendedor,
        transitionType: TransitionType.fadeIn);

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
