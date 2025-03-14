part of 'adoption_page_bloc.dart';

sealed class AdoptionPageState extends Equatable {
  const AdoptionPageState();
  
  @override
  List<Object> get props => [];
}

final class AdoptionPageInitial extends AdoptionPageState {}
