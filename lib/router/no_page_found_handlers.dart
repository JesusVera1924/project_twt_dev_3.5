import 'package:fluro/fluro.dart';
import 'package:devolucion_modulo/provider/side_menu_provider.dart';
import 'package:devolucion_modulo/ui/views/no_found_page_view.dart';
import 'package:provider/provider.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(
    handlerFunc: (context, params) {
      Provider.of<SideMenuProvider>(context!, listen: false)
          .setCurrentPageUrl('/404');
      return const NoPageFoundView();
    },
  );
}
