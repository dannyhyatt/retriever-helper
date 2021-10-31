import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpeningHoursPage extends StatefulWidget {
  const OpeningHoursPage({Key? key}) : super(key: key);

  @override
  _OpeningHoursPageState createState() => _OpeningHoursPageState();
}

class _OpeningHoursPageState extends State<OpeningHoursPage> {
  final times = {
    'Salsarita\'s': {
      'Sunday': {
        'opening': TimeOfDay(hour: 0, minute: 0),
        'closing': TimeOfDay(hour: 0, minute: 0)
      }
    },
    'True Grit\'s': {
      'Sunday': {
        'opening': TimeOfDay(hour: 11, minute: 0),
        'closing': TimeOfDay(hour: 23, minute: 0)
      }
    },
    'Hissho Sushi': {
      'Sunday': {
        'opening': TimeOfDay(hour: 12, minute: 0),
        'closing': TimeOfDay(hour: 18, minute: 0)
      }
    },
    'Retriever Market': {
      'Sunday': {
        'opening': TimeOfDay(hour: 13, minute: 0),
        'closing': TimeOfDay(hour: 20, minute: 0)
      }
    },
    'Halal Shack': {
      'Sunday': {
        'opening': TimeOfDay(hour: 0, minute: 0),
        'closing': TimeOfDay(hour: 0, minute: 0)
      }
    },
  };

  final DateFormat weekFormat = DateFormat('EEEE');

  var validRestaurants = {};

  @override
  void initState() {
    super.initState();
    validRestaurants = times;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  '${weekFormat.format(DateTime.now())} Hours',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.left,
                ),
              ),
              Table(
                children: [
                  ...validRestaurants.keys.map((e) => TableRow(children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: e),
                                TextSpan(
                                    text: e == 'True Grit\'s' ||
                                            e == 'Hissho Sushi'
                                        ? '∙'
                                        : '',
                                    style: TextStyle(color: Colors.green))
                              ]),
                        ),
                        Text(
                          validRestaurants[e]![getCurrentDayOfWeek()]![
                                              'opening']
                                          .hour +
                                      validRestaurants[e]![
                                              getCurrentDayOfWeek()]!['opening']
                                          .minute ==
                                  validRestaurants[e]![getCurrentDayOfWeek()]![
                                              'closing']
                                          .hour +
                                      validRestaurants[e]![
                                              getCurrentDayOfWeek()]!['closing']
                                          .minute
                              ? 'Closed Today'
                              : '${validRestaurants[e]![getCurrentDayOfWeek()]!['opening']?.format(context) ?? ''} - ${validRestaurants[e]![weekFormat.format(DateTime.now())]!['closing']?.format(context) ?? ''}',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.right,
                        )
                      ]))
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    onChanged: refreshList,
                    autofocus: false,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Filter...',
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void refreshList(String searchString) {
    var oldValidRestaurants = validRestaurants;
    validRestaurants = {};
    for (var key in times.keys) {
      // debugPrint('$key, $searchString, ${key.contains(searchString)}');
      if (key.toLowerCase().startsWith(searchString.toLowerCase())) {
        validRestaurants[key] = times[key];
      }
    }
    for (var key in times.keys) {
      if (key.toLowerCase().contains(searchString.toLowerCase()) &&
          validRestaurants[key] == null) {
        debugPrint('adding $key');
        validRestaurants[key] = times[key];
      }
    }
    if (validRestaurants != oldValidRestaurants)
      setState(() {
        debugPrint('changing list');
      });
  }

  String getCurrentDayOfWeek() {
    return weekFormat.format(DateTime.now());
  }
}
