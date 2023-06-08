import 'dart:convert';

import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/return_api.dart';

import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? cliente;
  final _api = ReturnApi();

  AuthProvider() {
    this.isAuthenticated();
  }

  forget(String email) async {
    this._token = email;
    LocalStorage.prefs.setString('correo', this._token!);
    notifyListeners();
  }

  login(String email, String password, Usuario usuario) async {
    this._token = usuario.ctaUsr;
    this.cliente = usuario;
    UtilView.usuario = usuario;
    LocalStorage.prefs.setString('token', this._token!);
    LocalStorage.prefs.setString('usuario', json.encode(usuario.toMap()));

    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.replaceTo(Flurorouter.menuRoute);
  }

  generar(String codRef) async {
    this._token = codRef;
    LocalStorage.prefs.setString('token', this._token!);
    authStatus = AuthStatus.authenticated;
    notifyListeners();
  }

  deleteToken() async {
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  register(Usuario user) {
    _api.postUsuario(user);
    NavigationService.replaceTo(Flurorouter.loginRoute);
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    final tokenUser = LocalStorage.prefs.getString('usuario');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    if (tokenUser == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //logica para verificar el token de llegada
    cliente = Usuario.fromMap(jsonDecode(tokenUser));
    UtilView.usuario = cliente!;

    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  logout() {
    LocalStorage.prefs.remove('token');
    LocalStorage.prefs.remove('usuario');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
