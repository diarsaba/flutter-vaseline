import 'package:chatest/widgets/custom_Button.dart';
import 'package:chatest/widgets/custom_input.dart';
import 'package:chatest/widgets/custom_labels.dart';
import 'package:chatest/widgets/custom_logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: "Login",),
                  _Form(),
                  Labels(ruta: 'register',title: '¿Quieres crear una cuenta?',subtitle: '¡Crear Ahora!',),
                  Text(
                    "Terminos y condiciones",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
        CustomInput(
          icon: Icons.email_outlined,
          placeholder: 'Email',
          keyboardType: TextInputType.emailAddress,
          textcontroller: emailCtrl,
        ),
        CustomInput(
          icon: Icons.password_outlined,
          placeholder: 'Password',
          keyboardType: TextInputType.visiblePassword,
          textcontroller: passCtrl,
          isPassword: true,
        ),
        ButtonBlue(
            text: "Entrar",
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            })
      ]),
    );
  }
}
