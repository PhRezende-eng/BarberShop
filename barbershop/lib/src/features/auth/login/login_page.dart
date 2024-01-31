import 'package:barber_shop/src/core/ui/constants.dart';
import 'package:barber_shop/src/core/ui/helpers/form_helper.dart';
import 'package:barber_shop/src/core/ui/helpers/messages.dart';
import 'package:barber_shop/src/features/auth/login/login_state.dart';
import 'package:barber_shop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BSLoginPage extends ConsumerStatefulWidget {
  const BSLoginPage({super.key});

  @override
  ConsumerState<BSLoginPage> createState() => _BSLoginPageState();
}

class _BSLoginPageState extends ConsumerState<BSLoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVM(:login) = ref.watch(loginVMProvider.notifier);

    ref.listen(
      loginVMProvider,
      (previous, next) {
        switch (next) {
          case LoginState(status: LoginStateStatus.initial):
            break;
          case LoginState(
              status: LoginStateStatus.error,
              errorMessage: final errorMessage?,
            ):
            Messages.showError(errorMessage, context);
          case LoginState(status: LoginStateStatus.error):
            Messages.showError("Error ao realizar login", context);
          case LoginState(status: LoginStateStatus.admLogin):
            break;
          case LoginState(status: LoginStateStatus.employeeLogin):
            break;

          default:
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImageConstants.backgroundChair),
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              ImageConstants.imageLogo,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required("E-mail obrigatório"),
                              Validatorless.email("E-mail inválido"),
                            ]),
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              hintText: 'Email',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required("Senha obrigatória"),
                              Validatorless.min(6,
                                  "Senha deve conter pelo menos 6 caracteres"),
                            ]),
                            obscureText: true,
                            controller: passwordEC,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: ColorsConstants.brown, fontSize: 12),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56)),
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case false || null:
                                  Messages.showError(
                                      "Campos inválidos", context);
                                case true:
                                  login(emailEC.text, passwordEC.text);
                              }
                            },
                            child: const Text("ACESSAR"),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverFillRemaining(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
