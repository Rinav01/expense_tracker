part of 'create_category_bloc.dart';

sealed class CreateCategoryState extends Equatable {
  const CreateCategoryState();

  @override
  List<Object> get props => [];
}

final class CreateCategoryInitial extends CreateCategoryState {}

final class CreateCategoryLoading extends CreateCategoryState {}

final class CreateCategorySuccess extends CreateCategoryState {}

final class CreateCategoryFailure extends CreateCategoryState {
  final String error; // Include error message

  const CreateCategoryFailure({required this.error}); // Constructor to pass the error message

  @override
  List<Object> get props => [error]; // Include error in props for equality comparison
}
