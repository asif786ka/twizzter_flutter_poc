import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twizzter/repositories/repositories.dart';
import 'package:twizzter/screens/login/cubit/login_cubit.dart';
import 'package:twizzter/screens/screens.dart';
import 'package:twizzter/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  LoginScreen({super.key});

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(context: context, builder: (context) => ErrorDialog(content: state.failure.message));
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Twitter GL Sample',
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12.0),
                            TextFormField(
                              decoration: const InputDecoration(hintText: 'Email'),
                              onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
                              validator: (value) => !value!.contains('@') ? 'Please enter a valid email.' : null,
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              decoration: const InputDecoration(hintText: 'Password'),
                              obscureText: true,
                              onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
                              validator: (value) => value!.length < 6 ? 'Must be at least 6 characters.' : null,
                            ),
                            const SizedBox(height: 28.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                onPrimary: Colors.white,
                                shadowColor: Colors.grey,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: const Size(100, 40), //////// HERE
                              ),
                              onPressed: () => _submitForm(
                                context,
                                state.status == LoginStatus.submitting,
                              ),
                              child: const Text('Log In'),
                            ),
                            const SizedBox(height: 12.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                                onPrimary: Colors.black,
                                shadowColor: Colors.grey,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: const Size(100, 40), //////// HERE
                              ),
                              onPressed: () => Navigator.of(context).pushNamed(SignupScreen.routeName),
                              child: const Text('No account? Sign up'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}