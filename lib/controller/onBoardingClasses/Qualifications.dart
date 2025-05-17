class Qualifications {
  late String qualification;
  late String university;
  late String course;
  late String specialization;
  late String courseType;
  late String passingYear;
  late List<String> skills;
  late String description;

  Qualifications({
    required this.qualification,
    required this.university,
    required this.course,
    required this.specialization,
    required this.courseType,
    required this.passingYear,
    required this.skills,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    "qualification": qualification,
    "university": university,
    "course": course,
    "specialization": specialization,
    "courseType": courseType,
    "passingYear": passingYear,
    "skills": skills,
    "description": description,
  };
}
