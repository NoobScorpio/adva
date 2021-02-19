import 'package:adva/bloc/address_bloc/addressState.dart';
import 'package:adva/data/model/address.dart';
import 'package:adva/data/repository/addressRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository addressRepository;

  AddressCubit({this.addressRepository}) : super(AddressInitialState());

  Future<void> getAddresses(int cid) async {
    try {
      emit(AddressLoadingState());
      final addresses = await addressRepository.getAddresses(cid);
      emit(AddressLoadedState(address: addresses));
    } on Exception {
      emit(AddressErrorState(message: "Could not get address"));
    }
  }

  Future<bool> addAddress(Address address) async {
    try {
      emit(AddressLoadingState());
      final addresses = await addressRepository.addAddress(address: address);
      emit(AddressAddState(addresses));
      return addresses != null ? true : false;
    } on Exception {
      emit(AddressErrorState(message: "Could not add address"));
      await getAddresses(address.customerId);
      return false;
    }
  }

  Future<bool> deleteAddress(Address address) async {
    try {
      emit(AddressLoadingState());
      final addresses = await addressRepository.deleteAddress(address: address);
      emit(AddressDeleteState(addresses));
      if (addresses == null)
        return false;
      else {
        await getAddresses(address.customerId);
        return true;
      }
    } on Exception {
      emit(AddressErrorState(message: "Could not delete address"));
      await getAddresses(address.customerId);

      return false;
    }
  }

  Future<bool> updateAddress(Address address) async {
    try {
      emit(AddressLoadingState());
      final updated = await addressRepository.updateAddress(address: address);
      if (updated) {
        final addresses =
            await addressRepository.getAddresses(address.customerId);
        emit(AddressLoadedState(address: addresses));
        return true;
      } else {
        emit(AddressErrorState(message: 'Couldnot update address'));
        await getAddresses(address.customerId);
        return false;
      }
    } on Exception {
      emit(AddressErrorState(message: "Could not get address"));
      await getAddresses(address.customerId);
      return false;
    }
  }
}
