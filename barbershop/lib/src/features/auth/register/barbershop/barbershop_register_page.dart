import 'package:barber_shop/src/core/ui/constants.dart';
import 'package:barber_shop/src/core/ui/helpers/form_helper.dart';
import 'package:barber_shop/src/core/ui/helpers/messages.dart';
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
  late Map<String, String?> selectedHours;
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
  Widget build(BuildContext context) {
    final registerVM = ref.watch(barbershopRegisterVMProvider.notifier);

    ref.listen(barbershopRegisterVMProvider, (_, state) {
      switch (state.status) {
        case (BarbershopRegisterStatus.initial):
        //TODO
        case (BarbershopRegisterStatus.error):
        //TODO
        case (BarbershopRegisterStatus.success):
        //TODO
      }
    });

    const hours = [
      "Seg",
      "Ter",
      "Qua",
      "Qui",
      "Sex",
      "Sáb",
      "Dom",
    ];

    const days = [
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
        padding: const EdgeInsets.all(16),
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
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selecione os dias da semana',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: hours
                          .map((hour) => BarberShopScheduleCard(
                                onTap: () {
                                  if (selectedHours[hour] == null) {
                                    selectedHours[hour] = hour;
                                  } else {
                                    selectedHours[hour] = null;
                                  }
                                  setState(() {});
                                },
                                schedule: hour,
                                selected: selectedHours[hour] == hour,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selecione os horários de atendimento',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: days.length ~/ 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 24,
              ),
              itemBuilder: (context, index) {
                final day = days[index];
                return BarberShopScheduleCard(
                  onTap: () {
                    if (selectedDays[day] == null) {
                      selectedDays[day] = day;
                    } else {
                      selectedDays[day] = null;
                    }
                    setState(() {});
                  },
                  schedule: day,
                  selected: selectedDays[day] == day,
                );
              },
              itemCount: days.length,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case (true):
                          registerVM.createBarbershop((
                            name: nameEC.text,
                            email: emailEC.text,
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

class BarberShopScheduleCard extends StatelessWidget {
  final String schedule;
  final bool selected;
  final VoidCallback onTap;
  const BarberShopScheduleCard({
    required this.schedule,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: !selected ? ColorsConstants.brown : Colors.white),
          color: selected ? ColorsConstants.brown : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Text(
          schedule,
          style: TextStyle(
              color: !selected ? ColorsConstants.brown : Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
