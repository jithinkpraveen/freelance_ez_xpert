import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/screen/auth/login/login_vm.dart';
import 'package:ez_xpert/screen/auth/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BasePage<LoginVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: (MediaQuery.of(context).size.height * 0.49),
              width: double.infinity,
              child: Image.asset(
                "assets/animation.gif",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 11,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Form(
                          key: provider.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter username';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  provider.email = newValue;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  contentPadding: const EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  hintText: "Email",
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                obscureText: provider.obscureText,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      provider.visiblePassword();
                                    },
                                    icon: Icon(provider.obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  contentPadding: const EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  hintText: "Password",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.toString().length < 6) {
                                    return 'Password must contain at least six characters!';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  provider.password = newValue;
                                },
                              ),
                              const SizedBox(height: 15),
                              MaterialButton(
                                minWidth: double.infinity,
                                height: 50,
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  provider.login();
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Click Here to"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ontext) => const SignUp(),
                                        ),
                                      );
                                    },
                                    child: const Text("Registration"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  LoginVM create() => LoginVM();

  @override
  void initialise(BuildContext context) {}
}
