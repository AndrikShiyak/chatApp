part of 'loader_bloc.dart';

@immutable
abstract class LoaderEvent {}

class IncrementLoader extends LoaderEvent {}

class DecrementLoader extends LoaderEvent {}
