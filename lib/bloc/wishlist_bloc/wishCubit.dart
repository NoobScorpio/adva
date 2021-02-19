import 'package:adva/bloc/wishlist_bloc/wishState.dart';
import 'package:adva/data/model/wishlist.dart';
import 'package:adva/data/repository/wishRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishCubit extends Cubit<WishListState> {
  final WishRepository wishRepository;

  WishCubit({this.wishRepository}) : super(WishListInitialState());

  Future<List<WishList>> getWishLists(int cid) async {
    try {
      emit(WishListLoadingState());
      List<WishList> wishLists = await wishRepository.getWishListItems(cid);
      emit(WishListLoadedState(wishLists: wishLists));
      return wishLists;
    } on Exception {
      emit(WishListErrorState(message: "Could not get wishes"));
      return null;
    }
  }

  Future<bool> removeWishListItem(int cid, int wid) async {
    try {
      // emit(WishListLoadingState());
      bool removed = await wishRepository.removeWishListItem(cid, wid);
      List<WishList> wishLists = await wishRepository.getWishListItems(cid);
      emit(WishListLoadedState(wishLists: wishLists));
      return removed;
    } on Exception {
      emit(WishListErrorState(message: "Could not get wishes"));
      return null;
    }
  }

  Future<int> addWishListItem(int cid, int pid) async {
    try {
      // emit(WishListLoadingState());
      int added = await wishRepository.addWishListItem(cid, pid);
      List<WishList> wishLists = await wishRepository.getWishListItems(cid);
      emit(WishListLoadedState(wishLists: wishLists));
      return added;
    } on Exception {
      emit(WishListErrorState(message: "Could not get wishes"));
      return null;
    }
  }
}
