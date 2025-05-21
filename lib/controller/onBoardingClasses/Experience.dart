class Experience {
  late String jobTitle;
  late String hospital;
  late String employmentType;
  late String location;
  late List<String> skills;
  late String startDate;
  late String? endDate;
  late String description;
  late bool currentlyWorking;

  Experience({
    required this.jobTitle,
    required this.hospital,
    required this.employmentType,
    required this.location,
    required this.skills,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.currentlyWorking,
  });

  Map<String, dynamic> toJson() => {
    "jobTitle": jobTitle,
    "hospital": hospital,
    "employmentType": employmentType,
    "location": location,
    "skills": skills,
    "startDate": startDate,
    "endDate": endDate,
    "description": description,
    "currentlyWorking": currentlyWorking,
  };
}
