import 'package:adva/bloc/ads_bloc/adsState.dart';
import 'package:adva/data/repository/adsRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAdsCubit extends Cubit<AdsState> {
  final AdsRepository adsRepository;

  GetAdsCubit({this.adsRepository}) : super(AdsInitialState());

  Future<void> getAds() async {
    try {
      emit(AdsLoadingState());
      final ads = await adsRepository.getAds();
      emit(AdsLoadedState(ads: ads));
    } on Exception {
      emit(AdsErrorState(message: "Could not get featured Items"));
    }
  }
}
