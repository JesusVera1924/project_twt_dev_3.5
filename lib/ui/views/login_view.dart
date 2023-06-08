import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/login_form_provider.dart';
import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final api = ReturnApi();

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(
        builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

          void sendLogin() async {
            final isValid = loginFormProvider.validateForm();
            if (isValid) {
              final ticket = await api.queryUsers(
                  loginFormProvider.usuario, loginFormProvider.password);
              if (ticket.length >= 1) {
                authProvider.login(loginFormProvider.usuario,
                    loginFormProvider.password, ticket.first);
              } else {
                NotificationsService.showSnackbar(
                    'Usuario / Password no válidos');
              }
            }
          }

          /*     void sendLogin() async {
            final isValid = loginFormProvider.validateForm();
            if (isValid) {
              final ticket =
                  await api.queryClienteDni(loginFormProvider.usuario);

              if (ticket.length == 1) {
                authProvider.login(loginFormProvider.usuario,
                    loginFormProvider.password, ticket.first.codRef);
              } else if (ticket.length > 1) {
                final opt = await customDialog4(context, ticket);
                if (opt != "")
                  authProvider.login(loginFormProvider.usuario,
                      loginFormProvider.password, opt);
              } else {
                customDialog1(
                    context,
                    'Error',
                    'Usuario o contraseña invalidos',
                    Icons.error_outline_outlined,
                    Colors.red);
              }
            } else {
              customDialog1(context, 'Error', 'Usuario o contraseña invalidos',
                  Icons.error_outline_outlined, Colors.red);
            }
          } */

          return Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: Form(
                    key: loginFormProvider.formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su usuario';
                            }
                            if (value.length <= 2) {
                              return 'La usuario debe ser mayor a 2 caracteres';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            loginFormProvider.usuario = value;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Ingrese su usuario',
                              label: 'Usuario',
                              icon: Icons.person),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            loginFormProvider.password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su password';
                            }

                            if (value.length < 6) {
                              return 'La password debe ser mayor o igual a 10 caracteres ';
                            }

                            return null;
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '******',
                              label: 'Password',
                              icon: Icons.lock_outline_rounded),
                          onEditingComplete: () async {
                            sendLogin();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomOutlinedButton(
                            onPressed: () async {
                              sendLogin();
                            },
                            text: 'Ingresar'),
                        SizedBox(height: 20),
                        LinkText(
                          text: 'Crear Cuenta',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Flurorouter.registerRoute);
                          },
                        ),
                        SizedBox(height: 5),
                        LinkText(
                          text: 'Recuperar Contraseña',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Flurorouter.forgetRoute);
                          },
                        ),
                        /*   SizedBox(height: 5),
                        LinkText(
                          text: 'Restablecer Contraseña',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Flurorouter.registerRoute);
                          },
                        ) */
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
