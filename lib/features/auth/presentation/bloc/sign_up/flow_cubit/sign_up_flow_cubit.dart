import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_flow_state.dart';

@injectable
class SignUpFlowCubit extends Cubit<SignUpFlowState> {
  SignUpFlowCubit() : super(const SignUpFlowState());

  void nextStep() {
    emit(state.copyWith(step: state.step + 1));
  }

  Future<bool> previosStep(BuildContext context) {
    if (state.step == 0) {
      return Future.value(true);
    }
    if (state.step == 1) {
      context.read<OTPCubit>().reset();
    } else if (state.step == 2) {
      context.read<CompleteFormCubit>().reset();
    }
    emit(state.copyWith(step: state.step - 1));
    return Future.value(false);
  }
}
