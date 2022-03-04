import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/screen/auth/signup/signup_vm.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with BasePage<SignupVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: Colors.white,
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
                    flex: 8,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 12,
                      child: SingleChildScrollView(
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
                                const SizedBox(height: 10),
                                const Text(
                                  "Registration",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                // const Spacer(),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    hintText: "Name",
                                  ),
                                  onSaved: (newValue) {
                                    provider.name = newValue;
                                  },
                                ),
                                const SizedBox(height: 15),
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
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email),
                                    contentPadding: const EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    hintText: "Email",
                                  ),
                                  onSaved: (newValue) {
                                    provider.email = newValue;
                                  },
                                ),
                                // const SizedBox(height: 15),
                                // TextFormField(
                                //   // validator: (value) {
                                //   //   if (value == null || value.isEmpty) {
                                //   //     return 'Please enter address';
                                //   //   }

                                //   //   return null;
                                //   // },
                                //   decoration: InputDecoration(
                                //     prefixIcon: const Icon(Icons.home),
                                //     contentPadding: const EdgeInsets.all(8.0),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(15.0),
                                //     ),
                                //     hintText: "Address",
                                //   ),
                                //   onSaved: (newValue) {
                                //     provider.address = newValue;
                                //   },
                                // ),
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
                                    provider.register();
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Back to"),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Login"),
                                    )
                                  ],
                                )
                              ],
                            ),
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
  SignupVM create() => SignupVM();

  @override
  void initialise(BuildContext context) {}
}
