import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:takugo/home/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:takugo/widgets/drawer.dart';

void main() {
  runApp(const RegisterApp());
}

enum UserType {
  none('Choose user type', ''),
  regular('Regular User', 'U'),
  institution('Institution', 'I');

  const UserType(this.label, this.value);
  final String label;
  final String value;
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String url = 'https://takugo-c04-tk.pbp.cs.ui.ac.id/auth/register/';
  String userType = UserType.none.value;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Register',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.yellow[700],
        ),
        drawer: const LeftDrawer(),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Username',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              DropdownMenu(
                dropdownMenuEntries: UserType.values.map((UserType userType) {
                  return DropdownMenuEntry(
                    value: userType,
                    label: userType.label,
                  );
                }).toList(),
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                leadingIcon: const Icon(Icons.type_specimen),
                initialSelection: UserType.none,
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onSelected: (type) {
                  userType = type!.value;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (userType.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('User Type Cannot be Empty'),
                          content: const Text(
                              'Please choose what type of user your account is.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    final response = await request.post(url, {
                      'username': username,
                      'password': password,
                      'user_type': userType,
                    });

                    if (context.mounted) {
                      if (response['status']) {
                        String msg = response['message'];
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Register Failed'),
                                  content: Text(response['msg']),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black87,
                  ),
                  child: const Text('Register',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                  text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())))
                ],
              ))
            ],
          ),
        ));
  }
}
