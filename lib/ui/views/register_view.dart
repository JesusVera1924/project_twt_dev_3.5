// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/register_form_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/ui/buttons/link_text.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/ui/dialog/cliente/show_dialog_client.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);

        ReturnApi returnApi = ReturnApi();

        return Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: ListView(
                  children: [
                    Form(
                        /*  autovalidateMode: AutovalidateMode.always, */
                        key: registerFormProvider.formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            // Nombre
                            TextFormField(
                              onChanged: (value) async {
                                registerFormProvider.dni = value;
                                if (value.length == 10 || value.length == 13) {
                                  final lista =
                                      await returnApi.queryUserDni(value);
                                  if (lista.length >= 1) {
                                    showDialogClient(context, lista);
                                  }
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Identificación es obligatario';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$')),
                              ],
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su identificación',
                                  label: 'Identificación',
                                  icon: Icons.supervised_user_circle_sharp),
                            ),
                            const SizedBox(height: 10),
                            // Usuario
                            TextFormField(
                              onChanged: (value) =>
                                  registerFormProvider.usuario = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El usuario es obligatario';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su nombre usuario',
                                  label: 'Nombre de usuario',
                                  icon: Icons.supervised_user_circle_sharp),
                            ),

                            const SizedBox(height: 10),

                            // Email
                            TextFormField(
                              onChanged: (value) =>
                                  registerFormProvider.tlfRef = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Celular es obligatario';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$')),
                              ],
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su celular',
                                  label: 'Celular',
                                  icon: Icons.email_outlined),
                            ),

                            const SizedBox(height: 10),

                            // Email
                            TextFormField(
                              onChanged: (value) =>
                                  registerFormProvider.email = value,
                              validator: (value) {
                                if (!EmailValidator.validate(value ?? '')) {
                                  return 'Email no válido';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su correo',
                                  label: 'Email',
                                  icon: Icons.email_outlined),
                            ),

                            const SizedBox(height: 10),

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

                                return null; // Válido
                              },
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: '*********',
                                  label: 'Contraseña',
                                  icon: Icons.lock_outline_rounded),
                            ),

                            const SizedBox(height: 10),
                            CustomOutlinedButton(
                              onPressed: () async {
                                final validForm =
                                    registerFormProvider.validateForm();
                                if (!validForm) return;

                                Usuario user = await returnApi
                                    .queryUserCor(registerFormProvider.email);

                                if (user.nomUsr != "") {
                                  NotificationsService.showSnackbar(
                                      'Correo ingresado ya exite');
                                  return;
                                }

                                final resp = await customDialog2(
                                    context,
                                    'Aviso',
                                    'Si está seguro de la información registrada\nde click en aceptar.',
                                    Icons.info_outline,
                                    Colors.blueGrey);

                                if (resp) {
                                  final authProvider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);

                                  authProvider.register(Usuario(
                                      codEmp: "01",
                                      codPry: "DEV",
                                      codUsr: registerFormProvider.usuario,
                                      nomUsr: registerFormProvider.nomRef,
                                      clvUsr: registerFormProvider.password,
                                      ctaUsr: registerFormProvider.codRef,
                                      nicUsr: registerFormProvider.dni,
                                      corUsr: registerFormProvider.email,
                                      celUsr: registerFormProvider.tlfRef,
                                      rolUsr: "C",
                                      clsUsr: "T",
                                      fexUsr: DateTime.now(),
                                      stsUsr: "A"));

                                  registerFormProvider.clearValue();

                                  NotificationsService.showSnackbar(
                                      'Usuario / Creado');

                                  Navigator.pushReplacementNamed(
                                      context, Flurorouter.loginRoute);
                                }
                              },
                              text: 'Crear cuenta',
                            ),

                            const SizedBox(height: 8),
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
