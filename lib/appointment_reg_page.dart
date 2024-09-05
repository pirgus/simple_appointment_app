import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

import 'components.dart';

const List<String> agreements = <String>['Unimed', 'ACIC', 'Particular'];

const List<String> customers = <String>['João', 'Maria', 'José'];
const List<String> professionals = <String>[
  'Dr. Fulano',
  'Dra. Ciclana',
  'Dr. Beltrano'
];

const Map colors = {
  'Vermelho': Colors.red,
  'Verde': Colors.green,
  'Rosa': Colors.pink,
  'Azul': Colors.blue,
};

const String CUSTOMERS_LABEL = 'Cliente';
const String PROFESSIONALS_LABEL = 'Profissional';
const String AGREEMENTS_LABEL = 'Convênio';
const String COLOR_LABEL = 'Situação';

class AppointmentRegistration extends StatefulWidget {
  const AppointmentRegistration(
      {super.key, required this.date, required this.calendar, required this.event});

  final DateTime date;
  final EventController calendar;
  final CustomEvent? event;

  @override
  State<AppointmentRegistration> createState() =>
      _AppointmentRegistrationState();
}

class _AppointmentRegistrationState extends State<AppointmentRegistration> {
  late String selectedAgreement;
  late String selectedCustomer;
  late String selectedProfessional;
  late DateTime selectedDate;
  late Color selectedColor;
  final begTimeTextController = TextEditingController();
  final endTimeTextController = TextEditingController();
  TimeOfDay selectedInitTime = TimeOfDay.now();
  TimeOfDay selectedEndTime =
      TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
  late DateTime selectedEndDate;

  @override
  void initState() {
    super.initState();
    selectedAgreement = widget.event?.agreement ?? agreements[0];
    selectedCustomer = widget.event?.customer ?? customers[0];
    selectedProfessional = widget.event?.professional ?? professionals[0];
    selectedDate = widget.date;
    selectedEndDate = selectedDate.add(const Duration(hours: 1));
    selectedInitTime = TimeOfDay.fromDateTime(selectedDate);
    selectedEndTime = TimeOfDay.fromDateTime(selectedDate.add(const Duration(hours: 1)));
    selectedColor =  widget.event?.color ?? colors.entries.first.value;
        begTimeTextController.value = TextEditingValue(
      text:
          '${selectedInitTime.hour}:${selectedInitTime.minute == 0 ? '00' : selectedInitTime.minute}',
    );

    endTimeTextController.value = TextEditingValue(
      text:
          '${selectedEndTime.hour}:${selectedEndTime.minute == 0 ? '00' : selectedEndTime.minute}',
    );

    begTimeTextController.addListener(_printLatestValueOfBegTime);
    endTimeTextController.addListener(_printLatestValueOfEndTime);
  }

  @override
  void dispose() {
    begTimeTextController.dispose();
    super.dispose();
  }

  void _printLatestValueOfBegTime() {
    final text = begTimeTextController.text;
    print('beggining time text: $text (${text.characters.length})');
  }

  void _printLatestValueOfEndTime() {
    final text = endTimeTextController.text;
    print('end time text: $text (${text.characters.length})');
  }

  void saveAppointment() {
    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedInitTime.hour,
      selectedInitTime.minute,
    );

    selectedEndDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedEndTime.hour,
      selectedEndTime.minute,
    );
    final appointment = CustomEvent(
      customer: selectedCustomer,
      professional: selectedProfessional,
      agreement: selectedAgreement,
      date: selectedDate,
      title: selectedCustomer,
      startDate: selectedDate,
      endDate: selectedDate,
      description: 'teste de agendamento',
      startTime: selectedDate,
      endTime: selectedEndDate,
      color: selectedColor,
    );

    // se ja houver evento passado como parametro, apenas o atualiza
    widget.event != null ? widget.calendar.update(widget.event!, appointment) :
    // senao, cria um evento
    widget.calendar.add(appointment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
        child: Form(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: DropdownMenu(
                        searchCallback:
                            (List<DropdownMenuEntry<String>> entries,
                                String query) {
                          final int index = entries.indexWhere(
                              (DropdownMenuEntry<String> entry) =>
                                  entry.label.contains(query));
                          if (index == -1) {
                            print('nao encontrou resultado');
                            return null;
                          }
                          return index;
                        },
                        // errorText: 'Nenhum registro encontrado',
                        initialSelection: selectedCustomer,
                        width: 400,
                        enableFilter: true,
                        enableSearch: true,
                        hintText: 'Selecione um cliente',
                        label: const Text(CUSTOMERS_LABEL),
                        requestFocusOnTap: true,
                        trailingIcon: const Icon(Icons.person_2_outlined),
                        inputDecorationTheme: inputDecorationTheme(context),
                        onSelected: (String? value) {
                          setState(() {
                            selectedCustomer = value!;
                          });
                        },
                        dropdownMenuEntries: customers
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry(value: value, label: value);
                        }).toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: DropdownMenu(
                      initialSelection: selectedProfessional,
                        width: 400,
                        enableFilter: true,
                        enableSearch: true,
                        label: const Text(PROFESSIONALS_LABEL),
                        requestFocusOnTap: true,
                        // trailingIcon: const Icon(Icons.perso),
                        inputDecorationTheme: inputDecorationTheme(context),
                        onSelected: (String? value) {
                          setState(() {
                            selectedProfessional = value!;
                          });
                        },
                        dropdownMenuEntries: professionals
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry(value: value, label: value);
                        }).toList()),
                  ),
                  DropdownButtonFormField(
                    padding: paddingForm(),
                    decoration: inputDecorationForm(AGREEMENTS_LABEL, context),
                    value: selectedAgreement,
                    items: agreements
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAgreement = newValue!;
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    padding: paddingForm(),
                    decoration: inputDecorationForm(COLOR_LABEL, context),
                    value: selectedColor,
                    items: colors.entries
                        .map<DropdownMenuItem<Color>>((MapEntry entry) {
                      return DropdownMenuItem(
                          value: entry.value,
                          child: Text(entry.key.toString()));
                    }).toList(),
                    onChanged: (Color? newValue) {
                      setState(() {
                        selectedColor = newValue!;
                      });
                    },
                  ),
                  InputDatePickerFormField(
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: widget.date,
                    onDateSubmitted: (DateTime value) {
                      setState(() {
                        selectedDate = DateTime(value.year, value.month,
                            value.day, selectedDate.hour, selectedDate.minute);
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Wrap(spacing: 20, children: [
                      SizedBox(
                        width: 175,
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: begTimeTextController,
                          readOnly: true,
                          decoration: inputDecorationForm('Início', context),
                          onTap: () {
                            selectTime(context).then((val) => {
                                  begTimeTextController.value =
                                      TextEditingValue(
                                    text:
                                        '${val.hour}:${val.minute == 0 ? '00' : val.minute}',
                                  ),
                                  setState(() {
                                    selectedInitTime = TimeOfDay(
                                        hour: val.hour, minute: val.minute);
                                  })
                                });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: endTimeTextController,
                          readOnly: true,
                          decoration: inputDecorationForm('Fim', context),
                          onTap: () {
                            selectTime(context).then((val) => {
                                  endTimeTextController.value =
                                      TextEditingValue(
                                    text:
                                        '${val.hour}:${val.minute == 0 ? '00' : val.minute}',
                                  ),
                                  setState(() {
                                    selectedEndTime = TimeOfDay(
                                        hour: val.hour, minute: val.minute);
                                  })
                                });
                          },
                        ),
                      ),
                    ]),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        saveAppointment();
                        Navigator.pop(context);
                      },
                      child: const Text('Salvar e voltar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry paddingForm() {
    return const EdgeInsets.fromLTRB(0, 0, 0, 20);
  }
}
