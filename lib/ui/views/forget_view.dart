import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/forget_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/ui/buttons/link_text.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_users.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class ForgetView extends StatefulWidget {
  @override
  _ForgetViewState createState() => _ForgetViewState();
}

class _ForgetViewState extends State<ForgetView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgetProvider(),
      child: Builder(builder: (context) {
        final forgetFormProvider =
            Provider.of<ForgetProvider>(context, listen: false);
        final api = ReturnApi();
        return Container(
          margin: EdgeInsets.only(top: 130),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: ListView(
                  children: [
                    Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: forgetFormProvider.formKey,
                        child: Column(
                          children: [
                            // Email
                            TextFormField(
                              controller: forgetFormProvider.codRef,
                              onChanged: (value) async {
                                if (value.length == 10 || value.length == 13) {
                                  final lista = await api.queryDni(value);
                                  if (lista.length >= 1) {
                                    await showDialogUsers(context, lista);
                                  }
                                }
                              },
                              validator: (value) {
                                if (value!.length < 10)
                                  return 'identificación incorrecta';

                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su Identificación',
                                  label: 'Identificación',
                                  icon: Icons.person),
                            ),

                            SizedBox(height: 10),
                            TextFormField(
                              controller: forgetFormProvider.email,
                              enabled: false,
                              validator: (value) {
                                if (!EmailValidator.validate(value ?? ''))
                                  return 'Email no válido';

                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese su correo',
                                  label: 'correo',
                                  icon: Icons.email_outlined),
                            ),

                            SizedBox(height: 5),
                            Text(
                                'Se le enviara un correo electronico con un codigo de acceso.\nSe suguiere que verifique en bandeja de correo no deseado o spam.\nSi su cuenta de correo no es la correcta comuniquese a nuestras oficinas.',
                                style: CustomLabels.h7),
                            SizedBox(height: 20),
                            CustomOutlinedButton(
                              onPressed: () async {
                                final validForm =
                                    forgetFormProvider.validateForm();
                                if (!validForm) return;

                                if (forgetFormProvider.user != null) {
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

                                    forgetFormProvider.user!.corUsr =
                                        forgetFormProvider.email.text;

                                    api.updateUser(forgetFormProvider.user!);

                                    api.postCorreo(forgetFormProvider.user!);

                                    authProvider
                                        .forget(forgetFormProvider.email.text);

                                    forgetFormProvider.clearValue();

                                    Navigator.pushReplacementNamed(
                                        context, Flurorouter.resetRoute);
                                  }
                                } else {
                                  NotificationsService.showSnackbar(
                                      'Correo / No encontrado');
                                }
                              },
                              text: 'Resetear Contraseña',
                            ),

                            SizedBox(height: 20),
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
