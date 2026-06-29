class JobApplication {
  final String id;
  final String company;
  final String roleTitle;
  final String status; // WISHLIST | APPLIED | INTERVIEW | REJECTED
  final String? jobUrl;
  final String? notes;
  final String? location;

  final DateTime? appliedDate;
  final DateTime createdAt;

  // Constructor
  JobApplication({
    required this.id,
    required this.company,
    required this.roleTitle,
    required this.status,
    this.jobUrl,
    this.notes,
    this.location,
    this.appliedDate,
    required this.createdAt,
  });

  // Converts the JSON your FastAPI backend sends into a Dart object
  factory JobApplication.fromJsontoDartObj(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'],
      company: json['company'],
      roleTitle: json['roleTitle'],
      status: json['status'],
      jobUrl: json['jobUrl'],
      notes: json['notes'],
      location: json['location'],
      appliedDate: json['dateApplied'] != null
          ? DateTime.parse(json['dateApplied'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

    // Converts a Dart object back into JSON to send TO your backend
  Map<String,dynamic> toJson(){
    return {
      'company' : company ,
      'roleTitle' : roleTitle ,
      'status' : status , 
      'jobUrl' : jobUrl , 
      'notes' : notes , 
      'location' : location , 
      'appliedDate' : appliedDate?.toIso8601String() ,
    } ; 
  }

}
