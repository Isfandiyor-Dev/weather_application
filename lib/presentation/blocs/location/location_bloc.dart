import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import '../../../domain/usecases/usecases.dart';
part "location_event.dart";
part "location_state.dart";

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  GetCurrentLocationUseCase getCurrentLocationUseCase;
  InitLocationUseCase initLocationUseCase;

  LocationBloc(
    this.getCurrentLocationUseCase,
    this.initLocationUseCase,
  ) : super(LocationInitialState()) {
    on<InitLocationEvent>(_initLocation);
    on<GetCurrentLocationEvent>(_getCurrentLocation);
  }

  void _initLocation(InitLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationPermissionRequestingState());
    try {
      bool isGranted = await initLocationUseCase.call();
      if (isGranted) {
        emit(LocationPermissionGrantedState());
      } else {
        emit(LocationPermissionDeniedState());
      }
    } catch (e) {
      emit(LocationFailureState(e.toString()));
    }
  }

  void _getCurrentLocation(GetCurrentLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());
    try {
      LocationData? locationData = await getCurrentLocationUseCase.call();
      emit(LocationLoadedState(locationData));
    } catch (e) {
      emit(LocationFailureState(e.toString()));
    }
  }
}
