import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';

part 'to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  final GetToDoListUseCase toDoListUseCase;

  ToDoListCubit({
    required this.toDoListUseCase,
  }) : super(const ToDoListState());

  Future<void> getToDoList() async {
    emit(
      state.copyWith(
        toDoList: [],
        isLoading: true,
      ),
    );
    final result = await toDoListUseCase();

    result.fold(
      (l) {
        emit(
          state.copyWith(
            isLoading: false,
            toDoList: [],
          ),
        );
      },
      (r) {
        return emit(
          state.copyWith(
            toDoList: r,
            isLoading: false,
          ),
        );
      },
    );
  }
}