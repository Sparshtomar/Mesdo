class Experience {
  late String jobTitle;
  late String hospital;
  late String location;
  late String startDate;
  late String endDate;
  late String description;

  Experience({
    required this.jobTitle,
    required this.hospital,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    "jobTitle": jobTitle,
    "hospital": hospital,
    "location": location,
    "startDate": startDate,
    "endDate": endDate,
    "description": description,
  };
}
