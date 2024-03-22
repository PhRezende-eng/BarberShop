import 'dart:developer';

import 'package:barber_shop/src/core/ui/helpers/form_helper.dart';
import 'package:barber_shop/src/core/ui/helpers/messages.dart';
import 'package:barber_shop/src/features/auth/register/user_register_state.dart';
import 'package:barber_shop/src/features/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  late GlobalKey<FormState> formKey;

  late TextEditingController nameEC;
  late TextEditingController emailEC;
  late TextEditingController passwordEC;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameEC = TextEditingController();
    emailEC = TextEditingController();
    passwordEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state.status) {
        case UserRegisterStateStatus.initial:
          log('message');
        case UserRegisterStateStatus.error:
          Messages.showError(state.errorMessage!, context);
        case UserRegisterStateStatus.success:
          Navigator.pushNamed(context, '/auth/register/barbershop');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameEC,
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.required('Nome é obrigatório'),
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: Text('Nome'),
                    hintText: 'Nome',
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailEC,
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('O email é obrigatório'),
                    Validatorless.email('Digite um email válido'),
                  ]),
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: Text('E-mail'),
                    hintText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: passwordEC,
                        onTapOutside: (_) => context.unfocus(),
                        validator: Validatorless.multiple([
                          Validatorless.required('A senha é obrigatório'),
                          Validatorless.min(5,
                              'A senha precisa ter mais do que 5 caracteres'),
                        ]),
                        // obscureText: true,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Text('Senha'),
                          hintText: 'Senha',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: TextFormField(
                        onTapOutside: (_) => context.unfocus(),
                        validator: Validatorless.multiple([
                          Validatorless.required('A senha é obrigatória'),
                          Validatorless.min(5,
                              'A senha precisa ter mais do que 5 caracteres'),
                          Validatorless.compare(passwordEC, 'Senha diferentes'),
                        ]),
                        // obscureText: true,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Text('Repita senha'),
                          hintText: 'Repita senha',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case true:
                        userRegisterVm.registerUser((
                          email: emailEC.text,
                          name: nameEC.text,
                          password: passwordEC.text,
                        ));
                      default:
                        Messages.showError("Campos inválidos", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text('CRIAR CONTA'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
