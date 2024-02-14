// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/provider/reset_form_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/ui/buttons/link_text.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:provider/provider.dart';

class ResetPassView extends StatelessWidget {
  const ResetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<ResetFormProvider>(context, listen: false);
        ReturnApi api = ReturnApi();

        return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: ListView(
                  children: [
                    Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: registerFormProvider.formKey,
                        child: Column(
                          children: [
                            // Nombre
                            TextFormField(
                              onChanged: (value) =>
                                  registerFormProvider.codigo = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El codigo es obligatario';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$')),
                              ],
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su codigo provisional',
                                  label: 'Codigo provisional',
                                  icon: Icons.supervised_user_circle_sharp),
                            ),
                            const SizedBox(height: 20),

                            // Password
                            TextFormField(
                              onChanged: (value) =>
                                  registerFormProvider.password = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese su contraseña';
                                }
                                if (value.length < 6) {
                                  return 'La contraseña debe de ser de 6 caracteres';
                                }
                                if (registerFormProvider.password !=
                                    registerFormProvider.password2) {
                                  return 'No coincide la contraseña';
                                }

                                return null; // Válido
                              },
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: '*********',
                                  label: 'Contraseña',
                                  icon: Icons.lock_outline_rounded),
                            ),
                            const SizedBox(height: 20),
                            // Password
                            TextFormField(
                              onChanged: (value) =>
                                  registerFormProvider.password2 = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese su contraseña';
                                }
                                if (value.length < 6) {
                                  return 'La contraseña debe de ser de 6 caracteres';
                                }
                                if (registerFormProvider.password !=
                                    registerFormProvider.password2) {
                                  return 'No coincide la contraseña';
                                }

                                return null; // Válido
                              },
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: '*********',
                                  label: 'Repita su contraseña',
                                  icon: Icons.lock_outline_rounded),
                            ),

                            const SizedBox(height: 20),
                            CustomOutlinedButton(
                              onPressed: () async {
                                final validForm =
                                    registerFormProvider.validateForm();
                                if (!validForm) return;
                                final token =
                                    LocalStorage.prefs.getString('correo');

                                Usuario user = await api.queryUserCor(token!);

                                if (user.clvUsr ==
                                    registerFormProvider.codigo) {
                                  user.clvUsr = registerFormProvider.password;

                                  api.updateUser(user);

                                  registerFormProvider.clearValue();

                                  NotificationsService.showSnackbar(
                                      'Cambio de contraseña exitoso');

                                  Navigator.pushReplacementNamed(
                                      context, Flurorouter.loginRoute);
                                } else {
                                  NotificationsService.showSnackbar(
                                      'No Exite el codigo ingresado');
                                }
                              },
                              text: 'Cambiar Contraseña',
                            ),

                            const SizedBox(height: 20),
                            LinkText(
                              text: 'Ir al login',
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Flurorouter.loginRoute);
                              },
                            )
                          ],
                        )),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
