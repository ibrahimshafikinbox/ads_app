abstract class VerficationStates {}

class VerifyAccountInitial extends VerficationStates {}

// OTP States

class SendOTPLoding extends VerficationStates {}

class SendOTPSuccess extends VerficationStates {}

class SendOTPError extends VerficationStates {}

// verfication States
class VerifyAccountLoding extends VerficationStates {}

class VerifyAccountSuccess extends VerficationStates {}

class VerifyAccountError extends VerficationStates {}

// callKit Satates
class CallAccepted extends VerficationStates {
  final String callerName;
  CallAccepted(this.callerName);
}

class CallDeclined extends VerficationStates {}

class CallEnded extends VerficationStates {}
