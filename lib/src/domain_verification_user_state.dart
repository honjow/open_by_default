enum DomainVerificationUserState {
  verified,
  selected,
  none,
}

extension ExtInt on int {
  DomainVerificationUserState get verificationState {
    if (this == 1) {
      return DomainVerificationUserState.selected;
    } else if (this == 2) {
      return DomainVerificationUserState.verified;
    } else {
      return DomainVerificationUserState.none;
    }
  }
}
