import 'package:flutter/material.dart';
import 'package:good_mentality/pages/set_sleep.dart';
import 'package:good_mentality/pages/good_sleep_practice.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});
  static const String _aboutSleep =
      " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. [Czyt. dalej]";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubPage(1)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(double.infinity,
                        MediaQuery.of(context).size.height / 5),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Text('Informacje na temat snu:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 4),
                      Text(_aboutSleep,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.normal,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetSleepPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(double.infinity,
                        MediaQuery.of(context).size.height / 5),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text('Ustaw sennik',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Dobre praktyki dotyczące snu: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        )),
                    // Reszta Twojego kodu
                    Expanded(
                      child: ListView(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubPage(1)),
                              );
                            },
                            child: Text(
                              'Odżywianie',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubPage(2)),
                              );
                            },
                            child: Text(
                              'Uzywanie elektroniki',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubPage(3)),
                              );
                            },
                            child: Text(
                              'Stała pora zasypiania',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubPage(4)),
                              );
                            },
                            child: Text(
                              'Nie objadanie się',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
