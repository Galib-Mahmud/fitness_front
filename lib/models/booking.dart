import 'trainer.dart';

enum BookingStatus { confirmed, completed, cancelled }

class Booking {
  final String id;
  final Trainer trainer;
  final String dateTimeText;
  final String dateOnly;
  final String timeOnly;
  final String sessionType;
  final String location;
  final BookingStatus status;
  final double cost;

  const Booking({
    required this.id,
    required this.trainer,
    required this.dateTimeText,
    required this.dateOnly,
    required this.timeOnly,
    required this.sessionType,
    required this.location,
    required this.status,
    required this.cost,
  });

  static List<Booking> sampleBookings = [
    Booking(
      id: 'b1',
      trainer: Trainer.sampleTrainers[0],
      dateTimeText: 'Today · 6:00 PM',
      dateOnly: 'Today, Oct 12',
      timeOnly: '6:00 PM - 7:00 PM',
      sessionType: '1-on-1 Strength Training',
      location: 'MetroFlex Fitness Hub, NY',
      status: BookingStatus.confirmed,
      cost: 65.0,
    ),
    Booking(
      id: 'b2',
      trainer: Trainer.sampleTrainers[1],
      dateTimeText: 'Tomorrow · 9:00 AM',
      dateOnly: 'Tomorrow, Oct 13',
      timeOnly: '9:00 AM - 10:00 AM',
      sessionType: 'Mobility & Recovery Flow',
      location: 'Equinox Studio 4, NY',
      status: BookingStatus.confirmed,
      cost: 70.0,
    ),
    Booking(
      id: 'b3',
      trainer: Trainer.sampleTrainers[2],
      dateTimeText: 'Friday · 5:30 PM',
      dateOnly: 'Oct 17, 2026',
      timeOnly: '5:30 PM - 6:30 PM',
      sessionType: 'Metabolic Conditioning HIIT',
      location: 'Brooklyn Athletic Club',
      status: BookingStatus.confirmed,
      cost: 60.0,
    ),
    Booking(
      id: 'b4',
      trainer: Trainer.sampleTrainers[0],
      dateTimeText: 'Last Week · Completed',
      dateOnly: 'Oct 5, 2026',
      timeOnly: '6:00 PM - 7:00 PM',
      sessionType: 'Upper Body Hypertrophy',
      location: 'MetroFlex Fitness Hub, NY',
      status: BookingStatus.completed,
      cost: 65.0,
    ),
    Booking(
      id: 'b5',
      trainer: Trainer.sampleTrainers[3],
      dateTimeText: 'Sep 28 · Completed',
      dateOnly: 'Sep 28, 2026',
      timeOnly: '7:00 AM - 8:00 AM',
      sessionType: 'Powerlifting Fundamentals',
      location: 'Ironworks Gym',
      status: BookingStatus.completed,
      cost: 75.0,
    ),
  ];
}
