import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BirthdayAnniversaryPage extends StatefulWidget {
  const BirthdayAnniversaryPage({Key? key}) : super(key: key);

  @override
  _BirthdayAnniversaryPageState createState() => _BirthdayAnniversaryPageState();
}

class _BirthdayAnniversaryPageState extends State<BirthdayAnniversaryPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF382758), // Dark background color
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color(0xFF382758), // AppBar color
        elevation: 0,
        actions: [
    IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF382758), // Background color for the circular box
        ),
        child: const Text(
          '👦', // Emoji for home
          style: TextStyle(fontSize: 24), // Adjust size as needed
        ),
      ),
      onPressed: () {
        // Navigate to Home page
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    ),
  ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Slot Information
              const Center(
                child: Text(
                  'GENERAL 10:00 AM TO 7:00 PM',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 16.0),

              // Calendar Widget
              _buildCalendar(),

              const SizedBox(height: 24.0),

              // Birthday Section
              _buildSection(
                title: 'Today Birthday',
                count: 2,
                buttonLabel: 'Birthday Wishing',
                emojiList: [
                  '👧', '👦', // Placeholder emojis for avatars
                ],
              ),

              const SizedBox(height: 24.0),

              // Anniversary Section
              _buildSection(
                title: 'Anniversary',
                count: 3,
                buttonLabel: 'Anniversary Wishing',
                emojiList: [
                  '👩', '👨', '🧑', // Placeholder emojis for avatars
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build the Calendar
  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color.fromARGB(255, 179, 123, 253),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xFFB48DE8).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: false,
          weekendTextStyle: const TextStyle(color: Colors.black),
          defaultTextStyle: const TextStyle(color: Colors.black),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
        ),
        calendarFormat: CalendarFormat.month,
      ),
    );
  }

  // Helper function to build Birthday/Anniversary Section
  Widget _buildSection({
    required String title,
    required int count,
    required String buttonLabel,
    required List<String> emojiList,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF5C4B85), // Background color for section
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.star, color: Colors.orangeAccent), // Star icon
            ],
          ),
          const SizedBox(height: 8.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: emojiList.map((emoji) {
              return Container(
                padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF382758), // Background color for the emoji container
              ),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 32),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 8.0),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Total\t\t\t\t',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                Text(
                  '|  $count  |',
                  style: const TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send, color: Colors.white),
              label: Text(buttonLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB48DE8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
