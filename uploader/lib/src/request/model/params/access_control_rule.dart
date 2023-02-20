class AccessControlRule {
  AccessType accessType;
  DateTime? start;
  DateTime? end;

  AccessControlRule(this.accessType, this.start, this.end);

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
