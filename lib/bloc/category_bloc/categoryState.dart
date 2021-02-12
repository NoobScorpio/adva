import 'package:adva/data/model/ads.dart';
import 'package:adva/data/model/category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitialState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final List<Category> category;

  CategoryLoadedState({@required this.category});

  @override
  // TODO: implement props
  List<Object> get props => [category];
}

class CategoryErrorState extends CategoryState {
  final String message;

  CategoryErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
