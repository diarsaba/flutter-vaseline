import 'package:chatest/pages/chat_page.dart';
import 'package:chatest/pages/loading_page.dart';
import 'package:chatest/pages/login_page.dart';
import 'package:chatest/pages/register_page.dart';
import 'package:chatest/pages/users_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => const UsersPage(),
  'chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingPage(),
};
