abstract class PaymentStates {}

class IntialPayment extends PaymentStates {}

class LoadingAuthTokenPaymentState extends PaymentStates {}

class SuccessAuthTokenPaymentState extends PaymentStates {}

class FailureAuthTokenPaymentState extends PaymentStates {}

class LoadingOrderIdPaymentState extends PaymentStates {}

class SuccessOrderIdPaymentState extends PaymentStates {}

class FailureOrderIdPaymentState extends PaymentStates {}

class LoadingRequestTokenPaymentState extends PaymentStates {}

class SuccessRequestTokenPaymentState extends PaymentStates {}

class FailureRequestTokenPaymentState extends PaymentStates {}
