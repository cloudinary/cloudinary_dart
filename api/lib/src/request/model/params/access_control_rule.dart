class AccessControlRule {
  AccessType accessType;
  DateTime? start;
  DateTime? end;

  AccessControlRule(this.accessType, this.start, this.end);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    result.addEntries({'access_type': accessType.name}.entries);
    (start != null)
        ? result.addEntries({'start': start.toString()}.entries)
        : null;
    (end != null) ? result.addEntries({'end': end.toString()}.entries) : null;
    return result;
  }

  factory AccessControlRule.fromJson(Map<String, dynamic> data) {
    final accessType = AccessType.values.firstWhere(
        (element) => element.toString() == 'AccessType.${data['access_type']}');
    final start =
        (data['start'] != null) ? DateTime.parse(data['start']) : null;
    final end = (data['end'] != null) ? DateTime.parse(data['end']) : null;
    return AccessControlRule(accessType, start, end);
  }

  static AccessControlRule token() {
    return AccessControlRule(AccessType.token, null, null);
  }

  static AccessControlRule anonymousUntil(DateTime? end) {
    return AccessControlRule(AccessType.anonymous, null, end);
  }

  static AccessControlRule anonymous(DateTime? start, DateTime? end) {
    return AccessControlRule(AccessType.anonymous, start, end);
  }
}

enum AccessType { anonymous, token }
