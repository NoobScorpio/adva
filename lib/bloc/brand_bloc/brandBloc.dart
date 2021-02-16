// import 'package:adva/data/model/brand.dart';
// import 'package:adva/data/repository/brandRepo.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class BrandBloc extends Bloc<BrandEvent, BrandState> {
//   final BrandRepository repository;
//
//   BrandBloc({this.repository}) : super(null);
//
//   @override
//   // TODO: implement initialState
//   BrandState get initialState => BrandInitialState();
//
//   @override
//   Stream<BrandState> mapEventToState(BrandEvent event) async* {
//     if (event is FetchBrandEvent) {
//       yield BrandLoadingState();
//       try {
//         print('FetchBrandEvent Called');
//         List<Brand> brands = await repository.getBrands();
//         print('FetchBrandEvent RETURN');
//         yield BrandLoadedState(brands: brands);
//       } catch (e) {
//         print('FetchBrandEvent Error');
//         yield BrandErrorState(message: e.toString());
//       }
//     }
//   }
//
//   @override
//   Future<void> close() {}
// }
//
