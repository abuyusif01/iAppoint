import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 60,
        bookingEnd: DateTime(now.year, now.month, now.day, 24, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 9, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value(["sdfsdf"]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 10));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));

    FirebaseFirestore.instance.collection('users').doc("sdf@f.com").update({
      'booking_start': newBooking.toJson()['bookingStart'],
      'booking_end': newBooking.toJson()['bookingEnd'],
      'booking_date': newBooking.toJson()['bookingDate'],
      'booking_duration': newBooking.toJson()['serviceDuration'],
    }).then((_) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //       content: Text('Booking Successpully'),
      //       backgroundColor: Colors.green),
      // );
      Navigator.pushNamed(context, 'user_details');
    });
    // print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    // DateTime first = now;
    // DateTime second = now.add(const Duration(minutes: 55));
    // DateTime third = now.subtract(const Duration(minutes: 240));
    // DateTime fourth = now.subtract(const Duration(minutes: 500));
    // converted.add(
    //     DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    // converted.add(DateTimeRange(
    //     start: second, end: second.add(const Duration(minutes: 23))));
    // converted.add(DateTimeRange(
    //     start: third, end: third.add(const Duration(minutes: 15))));
    // converted.add(DateTimeRange(
    //     start: fourth, end: fourth.add(const Duration(minutes: 50))));
    return converted;
  }

  List<DateTimeRange> pauseSlots = [
    DateTimeRange(
        // this rule force
        start: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 0),
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 9)),
    DateTimeRange(
        // this rule force
        start: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 18),
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 24)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Appointment Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Appointment Page'),
          ),
          body: Center(
            child: BookingCalendar(
              bookingService: mockBookingService,
              convertStreamResultToDateTimeRanges: convertStreamResultMock,
              getBookingStream: getBookingStreamMock,
              uploadBooking: uploadBookingMock,
              pauseSlots: pauseSlots,
              pauseSlotText: 'Not working hours',
              hideBreakTime: false,
            ),
          ),
        ));
  }
}
