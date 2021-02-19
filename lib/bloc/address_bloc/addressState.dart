import 'package:adva/data/model/address.dart';
import 'package:equatable/equatable.dart';

abstract class AddressState extends Equatable {}

class AddressInitialState extends AddressState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddressLoadingState extends AddressState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddressLoadedState extends AddressState {
  final List<Address> address;

  AddressLoadedState({this.address});

  @override
  // TODO: implement props
  List<Object> get props => [address];
}

class AddressErrorState extends AddressState {
  final String message;

  AddressErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class AddressUpdateState extends AddressState {
  final bool update;

  AddressUpdateState(this.update);
  @override
  // TODO: implement props
  List<Object> get props => [update];
}

class AddressDeleteState extends AddressState {
  final List<Address> address;

  AddressDeleteState(this.address);
  @override
  // TODO: implement props
  List<Object> get props => [address];
}

class AddressAddState extends AddressState {
  final List<Address> address;

  AddressAddState(this.address);
  @override
  // TODO: implement props
  List<Object> get props => [address];
}
