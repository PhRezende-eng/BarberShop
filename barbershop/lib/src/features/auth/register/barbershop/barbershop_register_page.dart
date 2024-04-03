import 'package:barber_shop/src/core/ui/helpers/form_helper.dart';
import 'package:barber_shop/src/core/ui/helpers/messages.dart';
import 'package:barber_shop/src/core/ui/widgets/schedule_card.dart';
import 'package:barber_shop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  late Map<String, String?> selectedDays;
  late Map<String, int?> selectedHours;
  late TextEditingController nameEC;
  late TextEditingController emailEC;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameEC = TextEditingController();
    emailEC = TextEditingController();
    selectedDays = {};
    selectedHours = {};
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerVM = ref.watch(barbershopRegisterVMProvider.notifier);

    ref.listen(barbershopRegisterVMProvider, (_, state) {
      switch (state.status) {
        case (BarbershopRegisterStatus.initial):
          print('Initial');
        case (BarbershopRegisterStatus.error):
          Messages.showError(
            state.errorMessage ??
                "Error ao processar cadastro de estabelecimento",
            context,
          );

        case (BarbershopRegisterStatus.success):
          print('success');
      }
    });

    const hours = [
      "08:00",
      "09:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
      "21:00",
      "22:00",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameEC,
                      onTapOutside: (_) => context.unfocus(),
                      validator: Validatorless.required('O nome é obrigatório'),
                      decoration: const InputDecoration(
                        label: Text('Nome'),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: Validatorless.multiple([
                        Validatorless.required('O email é obrigatório'),
                        Validatorless.email('Digite um email válido'),
                      ]),
                      onTapOutside: (_) => context.unfocus(),
                      controller: emailEC,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: WeekdaysPanel(
                selectedDays: selectedDays,
              ),
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Selecione os horários de atendimento',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SliverGrid.builder(
              itemCount: hours.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: hours.length ~/ 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 24,
              ),
              itemBuilder: (context, index) {
                final value = index + 1;
                final hour = hours[index];
                return BarbershopScheduleButton(
                  label: hour,
                  onTap: () {
                    if (selectedHours[hour] == null) {
                      selectedHours[hour] = value;
                    } else {
                      selectedHours[hour] = null;
                    }
                  },
                );
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case (true):
                          registerVM.createBarbershop((
                            name: nameEC.text,
                            email: emailEC.text,
                            weekDays: selectedDays.values,
                            hours: selectedHours.values,
                          ));
                        default:
                          Messages.showError(
                              "Formulário da barbearia inválido", context);
                      }
                    },
                    child: const Text('Cadastrar estabelecimento'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
