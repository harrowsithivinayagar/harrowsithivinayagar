// special_days_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/special_days/special_days_screen_bloc.dart';
import 'package:harrowsithivinayagar/repository/special_days/special_days_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class SpecialDaysTab extends StatelessWidget {
  const SpecialDaysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecialDaysScreenBloc(SpecialDaysrepository())
        ..add(InitializeSpecialDaysScreen()),
      child: BlocBuilder<SpecialDaysScreenBloc, SpecialDaysScreenState>(
        builder: (context, state) {
          if (state is SpecialDaysScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpecialDaysScreenLoaded) {
            return Column(
              children: <Widget>[
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: state.focusedDay,
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onPageChanged: (focusedDay) {
                    context
                        .read<SpecialDaysScreenBloc>()
                        .add(ChangeFocusDayEvent(focusedDay));
                  },
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon:
                        Icon(Icons.arrow_back, color: Colors.orange),
                    rightChevronIcon:
                        Icon(Icons.arrow_forward, color: Colors.orange),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          right: 1,
                          bottom: 1,
                          child: _buildEventsMarker(date, events),
                        );
                      }
                      return null;
                    },
                    defaultBuilder: (context, date, _) {
                      final cleanDate =
                          DateTime(date.year, date.month, date.day);
                      if (state.events.containsKey(cleanDate)) {
                        return Container(
                          margin: const EdgeInsets.all(6.0),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  eventLoader: (day) => state.events[day] ?? [],
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.selectedMonthEvents.length,
                    itemBuilder: (context, index) {
                      final event = state.selectedMonthEvents[index];
                      return ListTile(
                        title: Text(event.event),
                        subtitle: Text(
                            '${event.date.day}-${event.date.month}-${event.date.year} - ${event.day}'),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SpecialDaysScreenError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List<dynamic> events) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
