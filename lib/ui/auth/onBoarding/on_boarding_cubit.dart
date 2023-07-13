import 'package:bloc/bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingInitial> {
  OnBoardingCubit() : super(OnBoardingInitial(4));

  onPageChanged(int count) {
    emit(OnBoardingInitial(count));
  }
}
