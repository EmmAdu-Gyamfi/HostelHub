part of 'search_hostel_cubit.dart';

abstract class SearchHostelState extends Equatable {
  const SearchHostelState();
  @override
  List<Object?> get props => [];
}

class SearchHostelInitial extends SearchHostelState {

}



class SearchHostelLoadingInProgress extends SearchHostelState{

}

class SearchHostelLoadingFailed extends SearchHostelState {
  final String? message;

  const SearchHostelLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SearchHostelLoadingSucceeded extends SearchHostelState{
  final List<Hostel> hostels;

  const SearchHostelLoadingSucceeded(this.hostels);

  @override
  // TODO: implement props
  List<Object?> get props => [hostels];

}

class SearchHostelCompleted extends SearchHostelState{
  final List<Hostel> hostels;

  const SearchHostelCompleted(this.hostels);

  @override
  // TODO: implement props
  List<Object?> get props => [hostels];

}

//filtering of hostels

class FilteredHostelResultsLoadingInProgress extends SearchHostelState{

}

class FilteredHostelResultsLoadingFailed extends SearchHostelState {
  final String? message;

  const FilteredHostelResultsLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class FilteredHostelResultsLoadingSucceeded extends SearchHostelState{
  final List<Hostel> hostels;

  const FilteredHostelResultsLoadingSucceeded(this.hostels);

  @override
  // TODO: implement props
  List<Object?> get props => [hostels];

}