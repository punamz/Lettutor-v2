enum Specialty {
  all('All', ''),
  conversationalEnglish('Conversational English', 'conversational-english'),
  businessEnglish('Business English', 'business-english'),
  englishForKids('English for Kids', 'english-for-kids'),
  toeic('TOEIC', 'toeic'),
  toefl('TOEFL', 'toefl'),
  ielts('IELTS', 'ielts'),
  pet('PET', 'pet'),
  ket('KET', 'ket');

  const Specialty(this.description, this.value);
  final String description;
  final String value;
}

enum Level {
  beginner('BEGINNER'),
  highBeginner('HIGHER_BEGINNER'),
  preIntermediate('PRE_INTERMEDIATE'),
  intermediate('INTERMEDIATE'),
  upperIntermediate('UPPER_INTERMEDIATE'),
  advanced('ADVANCED'),
  proficiency('PROFICIENCY');

  const Level(this.value);
  final String value;
}
