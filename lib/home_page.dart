import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'constants.dart';
import 'components.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _viewType = WEEK;
  final EventController controller = EventController();
  int dropDownValue = 1;
  String dropDownLabel = 'Sala 1';
  DateTime initialDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 2, 159, 243),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                  image: AssetImage('assets/images/dentist.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Agenda da sala',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                DropdownButton(
                  hint: Text(dropDownLabel,
                      style: const TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  // style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.white,
                  underline: Container(),
                  dropdownColor: const Color.fromARGB(255, 240, 240, 240),
                  // value: dropDownValue,
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value!;
                      dropDownLabel = value == 1
                          ? 'Sala 1'
                          : value == 2
                          ? 'Sala 2'
                          : 'Sala 3';
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Sala 1'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Sala 2'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Sala 3'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                child: const Image(
                    image: AssetImage('assets/images/logo_sante_login.png'))),
            ListTile(
              iconColor: _viewType == DAY ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
              leading: const Icon(Icons.calendar_view_day),
              title: const Text('Dia'),
              onTap: () {
                setState(() {
                  _viewType = DAY;
                });
              },
            ),
            ListTile(
              iconColor: _viewType == WEEK ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
              leading: const Icon(Icons.calendar_view_week),
              title: const Text('Semana'),
              onTap: () {
                setState(() {
                  _viewType = WEEK;
                });
              },
            ),
            ListTile(
              iconColor: _viewType == MONTH ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
              leading: const Icon(Icons.calendar_today),
              title: const Text('Mês'),
              onTap: () {
                setState(() {
                  _viewType = MONTH;
                });
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: calendarViewType(context),
      ),
      bottomNavigationBar: NavigationBar(destinations: <Widget>[
        const NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Menu',
        ),
        NavigationDestination(
            icon: FloatingActionButton(
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
                onPressed: () {
                  print('apertou');
                }),
            label: ''),
        const NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          label: 'Clientes',
        ),
      ]),
    );
  }

  StatefulWidget calendarViewType(BuildContext context) {
    return switch (_viewType) {
        WEEK => WeekView(
          initialDay: initialDay,
          minuteSlotSize: minuteSlot,
          weekNumberBuilder: (date) => const Text(''),
          hourIndicatorSettings: hourIndicatorSettings,
          timeLineStringBuilder: (date, {secondaryDate}) =>
              timeLineString(date),
          halfHourIndicatorSettings: halfHourSettings,
          showHalfHours: showHalfHour,
          showQuarterHours: showQuarterHour,
          weekPageHeaderBuilder: (startDate, endDate) => Container(
            color: Theme.of(context).colorScheme.surface,
            child: TextButton(
              onPressed: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: startDate,
                    helpText: 'Selecione uma data',
                    cancelText: 'Cancelar',
                    confirmText: 'Confirmar',
                    fieldLabelText: 'Data',
                    fieldHintText: 'dd/mm/aa',
                    errorFormatText: 'Formato de data inválido',
                    errorInvalidText: 'Data inválida',
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context),
                        child: child!,
                      );
                    }).then((picked) => {
                  setState(() {
                    initialDay = picked ?? initialDay;
                  })
                });
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        // color: Theme.of(context).colorScheme.onSurface,
                        // color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${monthTitles[startDate.month - 1]} ${startDate.year}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ---------------------------------------------------------------
          // quarto de hora ta mostrando errado por algum motivo misterioso
          // ---------------------------------------------------------------
          // quarterHourIndicatorSettings:
          //     const HourIndicatorSettings(color: Colors.grey, height: 0.5),

          // -------------- UM MODO DE MOSTRAR TRES DIAS NA SEMANA!!!! -------
          // startDay: WeekDays.monday,
          // weekDays: [WeekDays.monday, WeekDays.tuesday, WeekDays.wednesday],
          // weekPageHeaderBuilder: WeekHeader.hidden,
          weekDayBuilder: (DateTime day) => Container(
            alignment: Alignment.center,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text(
                  weekTitles[day.weekday - 1],
                  style: const TextStyle(
                      // color: Colors.black,
                      fontSize: 8),
                ),
                Text(
                  day.day.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          controller: controller,
          heightPerMinute: heightPerMinute,
          eventTileBuilder:
              (date, events, boundary, startDuration, endDuration) =>
              customEventTileBuilder(
                  date, events, boundary, startDuration, endDuration),
          startHour: startHour,
          endHour: endHour,
          onEventTap: (events, date) => navigateToAppointmentRegistration(
              context,
              events[0].startTime!,
              controller,
              events[0] as CustomEvent),
          onDateTap: (date) => navigateToAppointmentRegistration(
              context,
              date,
              controller,
              null),
        ),
        DAY => DayView(
          initialDay: initialDay,
          showHalfHours: showHalfHour,
          showQuarterHours: showQuarterHour,
          halfHourIndicatorSettings: halfHourSettings,
          hourIndicatorSettings: hourIndicatorSettings,
          minuteSlotSize: minuteSlot,
          controller: controller,
          heightPerMinute: heightPerMinute,
          startHour: startHour,
          endHour: endHour,
          eventTileBuilder:
              (date, events, boundary, startDuration, endDuration) =>
              customEventTileBuilder(
                  date, events, boundary, startDuration, endDuration),
          timeStringBuilder: (date, {secondaryDate}) =>
              timeLineString(date),
          dayTitleBuilder: (date) => Container(
            color: Colors.white,
            child: TextButton(
              onPressed: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: date,
                    helpText: 'Selecione uma data',
                    cancelText: 'Cancelar',
                    confirmText: 'Confirmar',
                    fieldLabelText: 'Data',
                    fieldHintText: 'dd/mm/aa',
                    errorFormatText: 'Formato de data inválido',
                    errorInvalidText: 'Data inválida',
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color.fromARGB(255, 2, 159, 243),
                            onPrimary: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child!,
                      );
                    }).then((picked) => {
                  setState(() {
                    initialDay = picked ?? initialDay; // para nao ter que deixar
                                                       // esse gerenciamento de estado aqui,
                                                       // usar BLoC
                  })
                });
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${monthTitles[date.month - 1]} ${date.year}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        weekDaysTitles[date.weekday - 1],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          onDateTap: (date) =>
              navigateToAppointmentRegistration(context, date, controller, null),
        ),
        MONTH => MonthView(
          controller: controller,
          onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
          onCellTap: (events, date) =>
              navigateToAppointmentRegistration(context, date, controller, events[0] as CustomEvent),
        ),
        _ => throw Exception('Invalid view type: $_viewType'),
      };
  }
}
