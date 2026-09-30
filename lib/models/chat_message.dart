class ChatConversation {
  final String id;
  final String participantName;
  final String avatarPath;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const ChatConversation({
    required this.id,
    required this.participantName,
    required this.avatarPath,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
  });

  static List<ChatConversation> sampleConversations = [
    const ChatConversation(
      id: 'c1',
      participantName: 'Alex Rivera',
      avatarPath: 'assets/images/trainer_avatar.png',
      lastMessage: "I've reviewed your squat videos! Great depth.",
      time: '10:42 AM',
      unreadCount: 2,
      isOnline: true,
    ),
    const ChatConversation(
      id: 'c2',
      participantName: 'Maya Thompson',
      avatarPath: 'assets/images/maya_thompson.png',
      lastMessage: 'Remember to do the thoracic mobility drill before bed!',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
    ),
    const ChatConversation(
      id: 'c3',
      participantName: 'Jordan Kim',
      avatarPath: 'assets/images/jordan_kim.png',
      lastMessage: 'Session confirmed for tomorrow morning at 7:00 AM.',
      time: 'Oct 8',
      unreadCount: 0,
      isOnline: true,
    ),
    const ChatConversation(
      id: 'c4',
      participantName: 'Ryan Park',
      avatarPath: 'assets/images/ryan_park.png',
      lastMessage: 'Keep up the protein intake target for this week.',
      time: 'Oct 4',
      unreadCount: 0,
      isOnline: false,
    ),
  ];
}

class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final String timestamp;
  final bool isRead;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.isRead = true,
  });

  static List<ChatMessage> sampleMessages = [
    const ChatMessage(
      id: 'm1',
      text: 'Hey Alex! Ready for our session today?',
      isMe: true,
      timestamp: '10:30 AM',
    ),
    const ChatMessage(
      id: 'm2',
      text: "Hey! Absolutely. We're focusing on heavy barbell squats and overhead presses today. Bring your lifting belt.",
      isMe: false,
      timestamp: '10:32 AM',
    ),
    const ChatMessage(
      id: 'm3',
      text: "Awesome, I've got my belt ready. Should I do a light warmup beforehand?",
      isMe: true,
      timestamp: '10:35 AM',
    ),
    const ChatMessage(
      id: 'm4',
      text: "Yes, 5 minutes on the rower and dynamic hip openers would be ideal.",
      isMe: false,
      timestamp: '10:38 AM',
    ),
    const ChatMessage(
      id: 'm5',
      text: "I've reviewed your squat videos! Great depth on the 225lb set.",
      isMe: false,
      timestamp: '10:42 AM',
    ),
  ];
}
