import 'package:adva/data/model/advaPoints.dart';
import 'package:equatable/equatable.dart';

class PointsState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PointsInitialState extends PointsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PointsLoadingState extends PointsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PointsLoadedState extends PointsState {
  final ADVAPoints aDVAPoints;

  PointsLoadedState(this.aDVAPoints);
  @override
  // TODO: implement props
  List<Object> get props => [aDVAPoints];
}

class PointsErrorState extends PointsState {
  final String message;

  PointsErrorState(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
