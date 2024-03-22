// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  CategoriesState({this.Categories});
  CategoriesModel? Categories;
  @override
  List<Object?> get props => [Categories];
  CategoriesState copyWith({CategoriesModel? Categories}) =>
      CategoriesState(Categories: Categories ?? this.Categories);
}

class CategoriesInitial extends CategoriesState {}
