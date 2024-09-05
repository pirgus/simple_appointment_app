import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'appointment_reg_page.dart';
import 'constants.dart';

// CUSTOM EVENT TILE -----------------------------------------------------------
// renderizacao customizada do tile de evento
// para mostrar tambem o nome do cliente e do profissional
class RoundedCustomEventTile extends RoundedEventTile {
  final String customer;
  final String professional;

  const RoundedCustomEventTile({
    super.key,
    required this.customer,
    required this.professional,
    required super.title,
    super.padding,
    super.margin,
    super.description,
    super.borderRadius,
    super.totalEvents,
    super.backgroundColor,
    super.titleStyle,
    super.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (customer.isNotEmpty)
              Expanded(
                child: Text(
                  customer,
                  style: titleStyle ??
                      TextStyle(
                        fontSize: 17,
                        color: backgroundColor.accent,
                      ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            if (professional.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    professional,
                    style: descriptionStyle ??
                        TextStyle(
                          fontSize: 12,
                          color: backgroundColor.accent.withAlpha(200),
                        ),
                  ),
                ),
              ),
          ],
        ));
  }
}

// CUSTOM EVENT TILE BUILDER ---------------------------------------------------
// funcao customizada para fazer o build do tile de evento, usando o widget de
// RoundedCustomEvenTile, declarado acima
Widget customEventTileBuilder(DateTime date, List<CalendarEventData> events,
    Rect boundary, DateTime startDuration, DateTime endDuration) {
  if (events.isNotEmpty) {
    final event = events[0] as CustomEvent;
    return RoundedCustomEventTile(
      customer: event.customer,
      professional: event.professional,
      borderRadius: BorderRadius.circular(10.0),
      title: event.title,
      totalEvents: events.length - 1,
      description: event.description,
      padding: const EdgeInsets.all(10.0),
      backgroundColor: event.color,
      margin: const EdgeInsets.all(2.0),
      titleStyle: event.titleStyle,
      descriptionStyle: event.descriptionStyle,
    );
  } else {
    return const SizedBox.shrink();
  }
}

// CUSTOM EVENT ----------------------------------------------------------------
// classe customizada para representar um evento, com campos adicionais para
// armazenar o nome do cliente, do profissional e o convenio utilizado
class CustomEvent extends CalendarEventData {
  final String customer;
  final String professional;
  final String agreement;

  CustomEvent({
    required super.title,
    required String super.description,
    required DateTime startDate,
    required DateTime super.startTime,
    required DateTime super.endTime,
    required DateTime super.endDate,
    required super.date,
    required this.customer,
    required this.professional,
    required this.agreement,
    required super.color,
  });
}

// DAY TILE BUILDER ------------------------------------------------------------
// funcao que retorna um botao com um icone de calendario e o mes e ano da data
// ao clicar abre um dialog para selecionar uma nova data

// ------- ainda nao implementado o backend, apenas a interface -------
Widget dayTileBuilder(
    DateTime date, BuildContext context, List<String> monthTitles, bool isDay) {
  return Container(
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
                  '${monthTitles[date.month - 1]} ${date.year}',
                  style: const TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          isDay
              ? Column(
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
              : const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

// TIME LINE STRING ------------------------------------------------------------
// funcao que retorna uma string no formato 'hh:mm' para o builder da timeline
String timeLineString(DateTime date) {
  return "${date.hour}:${date.minute == 0 ? '00' : date.minute}";
}

// OUTLINE BORDER --------------------------------------------------------------
// funcao que retorna um objeto de outline border para ser usado no input do
// form de agendamento
OutlineInputBorder outlineBorder(Color borderColor) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: borderColor,
    ),
  );
}

// INPUT DECORATION FORM--------------------------------------------------------
// funcao que retorna um objeto de input decoration para ser
// usado no form de agendamento
InputDecoration inputDecorationForm(String label, BuildContext context) {
  return InputDecoration(
    labelText: label,
    floatingLabelBehavior: floatingBehavior,
    alignLabelWithHint: alignLabelWithHint,
    filled: inputFilled,
    enabledBorder: outlineBorder(Theme.of(context).colorScheme.onSurface),
    focusedBorder: outlineBorder(Theme.of(context).colorScheme.primary),
  );
}

// INPUT DECORATION THEME ------------------------------------------------------
// funcao que retorna um objeto de input decoration theme para ser usado no
// dropdownmenu
InputDecorationTheme inputDecorationTheme(BuildContext context) {
  return InputDecorationTheme(
    floatingLabelBehavior: floatingBehavior,
    alignLabelWithHint: alignLabelWithHint,
    filled: inputFilled,
    enabledBorder: outlineBorder(Theme.of(context).colorScheme.onSurface),
    focusedBorder: outlineBorder(Theme.of(context).colorScheme.primary),
  );
}

// SELECT TIME -----------------------------------------------------------------
// funcao que retorna um objeto de timeofday selecionado pelo usuario, para
// definir o horario de inicio e fim do agendamento
Future<TimeOfDay> selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if(picked != null){
    return picked;
  }
  return TimeOfDay.now();
}

void navigateToAppointmentRegistration(
    BuildContext context, DateTime date, EventController calendar, CustomEvent? event) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AppointmentRegistration(date: date, calendar: calendar, event: event),
      ));
}