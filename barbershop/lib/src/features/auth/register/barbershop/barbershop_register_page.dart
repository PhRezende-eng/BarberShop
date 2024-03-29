import 'package:barber_shop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class BarbershopRegisterPage extends StatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  String? selectHour;
  String? selectDay;

  @override
  Widget build(BuildContext context) {
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
        title: Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TextFormField(),
                  SizedBox(height: 16),
                  TextFormField(),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Selecione os dias da semana',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: hours
                        .map((hour) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectHour = hour;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectHour != hour
                                        ? ColorsConstants.brown
                                        : Colors.white,
                                  ),
                                  color: selectHour == hour
                                      ? ColorsConstants.brown
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  hour,
                                  style: TextStyle(
                                      color: selectHour != hour
                                          ? ColorsConstants.brown
                                          : Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Selecione os horários de atendimento',
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (days.length / 3).toInt(),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectDay = days[index];
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectDay != days[index]
                          ? ColorsConstants.brown
                          : Colors.white,
                    ),
                    color: selectDay == days[index]
                        ? ColorsConstants.brown
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    days[index],
                    style: TextStyle(
                        color: selectDay != days[index]
                            ? ColorsConstants.brown
                            : Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
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
                        minimumSize: Size.fromHeight(56)),
                    onPressed: () {},
                    child: Text('Cadastrar estabelecimento'),
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
