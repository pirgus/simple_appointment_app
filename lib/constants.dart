import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const DAY = 0;
const WEEK = 1;
const MONTH = 2;
const List<String> weekTitles = ["S", "T", "Q", "Q", "S", "S", "D"];
const List<String> monthTitles = [
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro"
];

const List<String> weekDaysTitles = [
  'Segunda',
  'Terça',
  'Quarta',
  'Quinta',
  'Sexta',
  'Sábado',
  'Domingo'
];

const minuteSlot = MinuteSlotSize.minutes15;
const heightPerMinute = 3.0;
const startHour = 7;
const endHour = 20;
const showHalfHour = true;
const showQuarterHour = false;

const halfHourSettings = HourIndicatorSettings(
  lineStyle: LineStyle.dashed,
  dashSpaceWidth: 1,
  color: Colors.grey,
  height: 0.5,
);

const hourIndicatorSettings = HourIndicatorSettings(
  height: 0.5,
);

const floatingBehavior = FloatingLabelBehavior.always;
const alignLabelWithHint = true;
const inputFilled = true;


InputDecoration inputDecorationForm(String label, BuildContext context) {
  return InputDecoration(
    labelText: label,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    alignLabelWithHint: true,
    filled: true,
    // fillColor: Colors.grey[200],
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    ),
  );
}

const locales = <Locale>[
  Locale('pt', 'BR'),
  Locale('en'),
  Locale('es')];

const globalMaterialLocalizations = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];