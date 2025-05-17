class Experience {
  String? jobTitle;
  String? hospital;
  String? location;
  String? startDate;
  String? endDate;
  String? description;
  bool currentlyWorking;

  Experience({
    this.jobTitle,
    this.hospital,
    this.location,
    this.startDate,
    this.endDate,
    this.description,
    this.currentlyWorking = false,
  });

  Map<String, dynamic> toJson() => {
    "jobTitle": jobTitle,
    "hospital": hospital,
    "location": location,
    "startDate": startDate,
    "endDate": endDate,
    "description": description,
    "currentlyWorking": currentlyWorking,
  };
}
