class Qualifications {
  late String university;
  late String course;
  late String specialization;
  late String passingYear;
  late String description;

  Qualifications({required this.university, required this.course, required this.specialization, required this.passingYear, required this.description});

  Map<String, dynamic> toJson() => {
    "university": university,
    "course": course,
    "specialization": specialization,
    "passingYear": passingYear,
    "description": description,
  };
}
