part of 'filter_params_cubit.dart';

abstract class FilterParamsState extends Equatable {
  const FilterParamsState();
  @override
  List<Object?> get props => [];
}

class LoadingFilterParamsInitial extends FilterParamsState {

}

class LoadingFilterParamsInProgress extends FilterParamsState {

}

class LoadingFilterParamsFailed extends FilterParamsState {

  final String? Message;

  LoadingFilterParamsFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}

class LoadingFilterParamsSucceeded extends FilterParamsState {
  final FilterParams filterParams;
  LoadingFilterParamsSucceeded(this.filterParams);
  @override
  // TODO: implement props
  List<Object?> get props => [filterParams];
}
