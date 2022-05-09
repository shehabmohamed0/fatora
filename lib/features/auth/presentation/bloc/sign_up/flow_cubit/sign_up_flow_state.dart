part of 'sign_up_flow_cubit.dart';

@immutable
class SignUpFlowState extends Equatable {
  const SignUpFlowState({this.step = 0});
  final int step;

  SignUpFlowState copyWith({required int step}) => SignUpFlowState(step: step);
  @override
  List<Object> get props => [step];
}
