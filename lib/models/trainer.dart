class Trainer {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviewsCount;
  final int matchPercent;
  final int hourlyRate;
  final double distanceMi;
  final String bio;
  final List<String> skills;
  final List<String> certifications;
  final List<String> languages;
  final String imagePath;
  final String bannerPath;
  final String experienceYears;

  const Trainer({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewsCount,
    required this.matchPercent,
    required this.hourlyRate,
    required this.distanceMi,
    required this.bio,
    required this.skills,
    required this.certifications,
    required this.languages,
    required this.imagePath,
    required this.bannerPath,
    required this.experienceYears,
  });

  static const List<Trainer> sampleTrainers = [
    Trainer(
      id: '1',
      name: 'Alex Rivera',
      specialty: 'Strength & Conditioning',
      rating: 4.9,
      reviewsCount: 284,
      matchPercent: 96,
      hourlyRate: 65,
      distanceMi: 0.8,
      bio: 'Certified strength coach with 8+ years transforming clients through progressive overload and evidence-based programming.',
      skills: ['Strength', 'Hypertrophy', 'Olympic Lifting', 'Mobility'],
      certifications: ['NASM - Certified Personal Trainer', 'CSCS - Strength & Conditioning'],
      languages: ['English', 'Spanish'],
      imagePath: 'assets/images/trainer_avatar.png',
      bannerPath: 'assets/images/trainer_banner.png',
      experienceYears: '8+ Years',
    ),
    Trainer(
      id: '2',
      name: 'Maya Thompson',
      specialty: 'Yoga & Mobility Coach',
      rating: 5.0,
      reviewsCount: 192,
      matchPercent: 94,
      hourlyRate: 70,
      distanceMi: 1.2,
      bio: 'Specializing in functional mobility, flow yoga, and athletic recovery to keep your body pain-free and resilient.',
      skills: ['Vinyasa Yoga', 'Breathwork', 'Posture Correction', 'Flexibility'],
      certifications: ['RYT 500 Yoga Alliance', 'FMS Level 2'],
      languages: ['English', 'French'],
      imagePath: 'assets/images/trainer_card_2.png',
      bannerPath: 'assets/images/trainer_banner.png',
      experienceYears: '6+ Years',
    ),
    Trainer(
      id: '3',
      name: 'Jordan Kim',
      specialty: 'HIIT & Fat Loss Specialist',
      rating: 4.8,
      reviewsCount: 310,
      matchPercent: 92,
      hourlyRate: 60,
      distanceMi: 1.5,
      bio: 'High-intensity athletic conditioning designed to torch calories, build cardiovascular endurance, and shred fat efficiently.',
      skills: ['HIIT', 'Metabolic Conditioning', 'Kettlebells', 'Nutrition'],
      certifications: ['ACE Certified Trainer', 'Precision Nutrition L1'],
      languages: ['English', 'Korean'],
      imagePath: 'assets/images/trainer_card_3.png',
      bannerPath: 'assets/images/trainer_banner.png',
      experienceYears: '7+ Years',
    ),
    Trainer(
      id: '4',
      name: 'Ryan Park',
      specialty: 'CrossFit & Functional Fitness',
      rating: 4.9,
      reviewsCount: 145,
      matchPercent: 89,
      hourlyRate: 75,
      distanceMi: 2.1,
      bio: 'Former collegiate athlete helping everyday people build superhuman work capacity and bulletproof joint health.',
      skills: ['CrossFit', 'Calisthenics', 'Endurance', 'Powerlifting'],
      certifications: ['CrossFit L3 Trainer', 'USAW Sports Performance Coach'],
      languages: ['English'],
      imagePath: 'assets/images/trainer_card_1.png',
      bannerPath: 'assets/images/trainer_banner.png',
      experienceYears: '9+ Years',
    ),
  ];
}
