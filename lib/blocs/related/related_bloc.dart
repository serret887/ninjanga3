import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/related_repository.dart';
import './bloc.dart';

class RelatedBloc extends Bloc<RelatedEvent, RelatedState> {
  RelatedBloc(this.repository, this.id);

  @override
  RelatedState get initialState => RelatedUninitialized();

  final RelatedRepository repository;
  final String id;

  @override
  Stream<RelatedState> mapEventToState(
    RelatedEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
