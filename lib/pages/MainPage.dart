import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:whatdo/components/TodoComponent.dart';
import 'package:whatdo/components/Weather.dart';
List<String> titles = <String>[
  'Календарь  ',
  'Выполенных заданий',
  'Заметки'
];
var dateTime = DateTime.now();
var day = dateTime.day;
var month = dateTime.month;
var year = dateTime.year;
List<String> phases = <String>[
  'Советы мы принимаем каплями, зато раздаём ведрами',
  'Побороть дурные привычки можно только сегодня, а не завтра.',
  'Три вещи никогда не возвращаются обратно – время, слово, возможность. Поэтому: не теряй времени, выбирай слова, не упускай возможность.',
  ' Благородный человек предъявляет требования к себе, низкий человек предъявляет требования к другим',
  ' Люди в древности не любили много говорить. Они считали позором для себя не поспеть за собственными словами',
  '.Я не огорчаюсь, если люди меня не понимают, — огорчаюсь, если я не понимаю людей.',
  'Если ты ненавидишь – значит тебя победили',
  'Перед тем как мстить, вырой две могилы',
  ' В стране, где есть порядок, будь смел и в действиях, и в речах. В стране, где нет порядка, будь смел в действиях, но осмотрителен в речах',
  'На самом деле, жизнь проста, но мы настойчиво её усложняем',
  ' Лишь когда приходят холода, становится ясно, что сосны и кипарисы последними теряют свой убор .',
  'Счастье — это когда тебя понимают, большое счастье — это когда тебя любят, настоящее счастье — это когда любишь ты',
  'Красота есть во всем, но не всем дано это видеть',
  'Если тебе плюют в спину, значит ты впереди',
  'Давай наставления только тому, кто ищет знаний, обнаружив свое невежество',
  ' Не тот велик, кто никогда не падал, а тот велик – кто падал и вставал',
];
  var random = Random();
  var randomIndex =  random.nextInt(phases.length);
  var randomElement = phases[randomIndex];
var datasets = {

};
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          /*
          Сделать завтра красивое появление цитат добавить функциональность добавления заметок и отметку дней в календаре
          */
          title: Text("Приложение для жизни",style: const TextStyle(fontSize: 24 , fontFamily: 'italic'),),
          // This check specifies which nested Scrollable's scroll notification
          // should be listened to.
          //
          // When `ThemeData.useMaterial3` is true and scroll view has
          // scrolled underneath the app bar, this updates the app bar
          // background color and elevation.
          //
          // This sets `notification.depth == 1` to listen to the scroll
          // notification from the nested `ListView.builder`.
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.calendar_today),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.archive),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.note_add),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
           CalendarDart(context),
          TodoList(),
          WeatherWidget()
             
          ],
        ),
      ),
    );
  }
}

Widget CalendarDart (BuildContext  context){
  return Container(
    child: Column(
      children: [
        hintForAdd(context),
        HeatMap(
  datasets: {
    DateTime(year, month, day): 3,

  },
  colorMode: ColorMode.opacity,
startDate: DateTime.now().add(const Duration(days:-60)),
endDate:DateTime.now().add(const Duration(days:30)),
size: 40,
  showText: true,
  scrollable: true,
defaultColor: Color.fromARGB(255, 206, 220, 208),
  colorsets: {
    1: Color.fromARGB(255, 128, 237, 4),
    3: Colors.green,
    5: Colors.yellow,
    7: Colors.green,
    9: Colors.blue,
    11: Colors.indigo,
    13: Colors.purple,
  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
)
      ],
    ),
  );
  }
Widget hintForAdd ( BuildContext context){
  return  Text(randomElement,   style: TextStyle(
  color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  ),
  textAlign: TextAlign.center,
  overflow: TextOverflow.clip,
  maxLines: 3,);
}