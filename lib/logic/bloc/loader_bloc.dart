import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'loader_event.dart';
part 'loader_state.dart';

class LoaderBloc extends Bloc<LoaderEvent, int> {
  LoaderBloc() : super(0) {
    on<IncrementLoader>((event, emit) => emit(state + 1));
    on<DecrementLoader>((event, emit) => emit(state - 1));
  }
}
