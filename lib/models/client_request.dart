enum RequestCategory { all, newReq, renew, archive }

class ClientRequest {
  final String id;
  final String clientName;
  final String avatarPath;
  final String goal;
  final String requestedTime;
  final String dateText;
  final int sessionCount;
  final double budget;
  final RequestCategory category;
  final String note;

  const ClientRequest({
    required this.id,
    required this.clientName,
    required this.avatarPath,
    required this.goal,
    required this.requestedTime,
    required this.dateText,
    required this.sessionCount,
    required this.budget,
    required this.category,
    required this.note,
  });

  static List<ClientRequest> sampleRequests = [
    const ClientRequest(
      id: 'cr1',
      clientName: 'Sarah Jenkins',
      avatarPath: 'assets/images/client_profile_avatar.png',
      goal: 'Strength & Hypertrophy',
      requestedTime: 'Tue, Thu · 6:00 PM',
      dateText: 'Starts Oct 14',
      sessionCount: 12,
      budget: 780.0,
      category: RequestCategory.newReq,
      note: 'Looking to gain lean muscle and improve squat/deadlift form.',
    ),
    const ClientRequest(
      id: 'cr2',
      clientName: 'Michael Chang',
      avatarPath: 'assets/images/alex_johnson.png',
      goal: 'Monthly Package Renewal',
      requestedTime: 'Mon, Wed, Fri · 7:00 AM',
      dateText: 'Renewal Due Oct 15',
      sessionCount: 16,
      budget: 1040.0,
      category: RequestCategory.renew,
      note: 'Renewing existing training program. Down 8 lbs so far!',
    ),
    const ClientRequest(
      id: 'cr3',
      clientName: 'Elena Rostova',
      avatarPath: 'assets/images/maya_thompson.png',
      goal: 'Marathon Mobility Prep',
      requestedTime: 'Sat · 10:00 AM',
      dateText: 'Starts Oct 18',
      sessionCount: 8,
      budget: 560.0,
      category: RequestCategory.newReq,
      note: 'Need hip opening and ankle stability for upcoming NYC marathon.',
    ),
    const ClientRequest(
      id: 'cr4',
      clientName: 'David Miller',
      avatarPath: 'assets/images/jordan_kim.png',
      goal: 'Fat Loss & Conditioning',
      requestedTime: 'Completed Season',
      dateText: 'Archived Sep 30',
      sessionCount: 24,
      budget: 1560.0,
      category: RequestCategory.archive,
      note: 'Client achieved target weight of 175 lbs. Completed program.',
    ),
  ];
}
