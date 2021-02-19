import 'package:adva/bloc/points_bloc/pointsState.dart';
import 'package:adva/data/model/advaPoints.dart';
import 'package:adva/data/repository/pointsRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit({this.pointsRepository}) : super(PointsInitialState());
  final PointsRepository pointsRepository;

  Future<void> getPoints(int cid) async {
    try {
      emit(PointsLoadingState());
      ADVAPoints aDVAPoint = await pointsRepository.getPoints(cid);
      emit(PointsLoadedState(aDVAPoint));
    } catch (e) {
      emit(PointsErrorState(e));
    }
  }
}
