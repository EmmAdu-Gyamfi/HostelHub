part of 'get_hostels_cubit.dart';

abstract class HostelsState extends Equatable {
  const HostelsState();
  @override
  List<Object?> get props => [];
}

class HostelsInitial extends HostelsState {

}

class HostelsLoadingInProgress extends HostelsState{

}

class HostelsLoadingFailed extends HostelsState {
final String? message;

const HostelsLoadingFailed(this.message);

@override
  // TODO: implement props
  List<Object?> get props => [message];
}

class HostelsLoadingSucceeded extends HostelsState{
final List<Hostel> hostels;

const HostelsLoadingSucceeded(this.hostels);

@override
  // TODO: implement props
  List<Object?> get props => [hostels];

}

class NewHostelRetrievalSucceeded extends HostelsState{
  final Hostel hostel;

  const NewHostelRetrievalSucceeded(this.hostel);

  @override
  // TODO: implement props
  List<Object?> get props => [hostel];

}


