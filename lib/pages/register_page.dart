import 'package:chatest/widgets/custom_Button.dart';
import 'package:chatest/widgets/custom_input.dart';
import 'package:chatest/widgets/custom_labels.dart';
import 'package:chatest/widgets/custom_logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(title: "Registro",),
                _Form(),
                const Labels(ruta: 'login',title: '¿Ya tienes cuenta?',subtitle: '¡Ingresa Ahora!',),
                const Text(
                  "Terminos y condiciones",
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
        CustomInput(
          icon: Icons.verified_user_outlined,
          placeholder: 'Name',
          keyboardType: TextInputType.text,
          textcontroller: nameCtrl,
        ),
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
              print(nameCtrl.text);
            })
      ]),
    );
  }
}
