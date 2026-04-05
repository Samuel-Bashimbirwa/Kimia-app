// Common abstract form
abstract class ViolenceForm {
  Map<String, dynamic> toJson();
}

class WorkViolenceForm implements ViolenceForm {
  String companyName;
  String relationToAggressor; // manager, colleague, client
  String details;

  WorkViolenceForm({
    required this.companyName,
    required this.relationToAggressor,
    required this.details,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "context": "work",
      "company_name": companyName,
      "relation": relationToAggressor,
      "details": details,
    };
  }
}

class HomeViolenceForm implements ViolenceForm {
  String relationToAggressor; // husband, partner, relative
  bool childrenPresent;
  String details;

  HomeViolenceForm({
    required this.relationToAggressor,
    required this.childrenPresent,
    required this.details,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "context": "home",
      "relation": relationToAggressor,
      "children_present": childrenPresent,
      "details": details,
    };
  }
}

class TransportViolenceForm implements ViolenceForm {
  String transportType; // bus, taxi, moto
  String location;
  String details;

  TransportViolenceForm({
    required this.transportType,
    required this.location,
    required this.details,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "context": "transport",
      "transport_type": transportType,
      "location": location,
      "details": details,
    };
  }
}
