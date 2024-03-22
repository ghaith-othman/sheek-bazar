// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'auth_cubit.dart';

class AuthState extends Equatable {
  AuthState(
      {this.show = true,
      this.showconfirmpass = true,
      this.user_phone,
      this.user_password,
      this.loading = false,
      this.userNameForSignUp,
      this.phoneNumberForSignUp,
      this.passwordForSignUp,
      this.phoneNumberForResetPassword,
      this.newPasswordForReset,
      this.validationCode,
      this.userIdFromForgetPassword,
      this.confirmNewPasswordForReset,
      this.sendSMSSuccessfully = false,
      this.confirmPasswordForSignUp});
  bool show;
  bool showconfirmpass;
  bool? sendSMSSuccessfully;
  final String? user_phone;
  final String? user_password;
  final String? validationCode;
  final String? userIdFromForgetPassword;
  final String? userNameForSignUp;
  final String? phoneNumberForSignUp;
  final String? passwordForSignUp;
  final String? confirmPasswordForSignUp;
  final String? phoneNumberForResetPassword;
  final String? newPasswordForReset;
  final String? confirmNewPasswordForReset;
  bool loading;
  @override
  List<Object?> get props => [
        show,
        showconfirmpass,
        user_phone,
        sendSMSSuccessfully,
        user_password,
        loading,
        confirmNewPasswordForReset,
        validationCode,
        phoneNumberForResetPassword,
        userIdFromForgetPassword,
        userNameForSignUp,
        phoneNumberForSignUp,
        passwordForSignUp,
        confirmPasswordForSignUp,
        newPasswordForReset,
      ];
  AuthState copyWith(
          {bool? show,
          bool? showconfirmpass,
          bool? sendSMSSuccessfully,
          String? user_phone,
          String? validationCode,
          String? user_password,
          String? userIdFromForgetPassword,
          String? userNameForSignUp,
          String? phoneNumberForSignUp,
          String? phoneNumberForResetPassword,
          String? passwordForSignUp,
          String? confirmNewPasswordForReset,
          String? confirmPasswordForSignUp,
          String? newPasswordForReset,
          bool? loading}) =>
      AuthState(
        show: show ?? this.show,
        showconfirmpass: showconfirmpass ?? this.showconfirmpass,
        newPasswordForReset: newPasswordForReset ?? this.newPasswordForReset,
        validationCode: validationCode ?? this.validationCode,
        sendSMSSuccessfully: sendSMSSuccessfully ?? this.sendSMSSuccessfully,
        userIdFromForgetPassword:
            userIdFromForgetPassword ?? this.userIdFromForgetPassword,
        confirmNewPasswordForReset:
            confirmNewPasswordForReset ?? this.confirmNewPasswordForReset,
        user_phone: user_phone ?? this.user_phone,
        phoneNumberForResetPassword:
            phoneNumberForResetPassword ?? this.phoneNumberForResetPassword,
        user_password: user_password ?? this.user_password,
        loading: loading ?? this.loading,
        userNameForSignUp: userNameForSignUp ?? this.userNameForSignUp,
        phoneNumberForSignUp: phoneNumberForSignUp ?? this.phoneNumberForSignUp,
        passwordForSignUp: passwordForSignUp ?? this.passwordForSignUp,
        confirmPasswordForSignUp:
            confirmPasswordForSignUp ?? this.confirmPasswordForSignUp,
      );
}

class AuthInitial extends AuthState {}
