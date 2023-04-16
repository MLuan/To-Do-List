import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/update_to_do_list_use_case_use_case.dart';

part 'to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  final GetToDoListUseCase toDoListUseCase;
  final UpdateToDoListUsecase updateToDoListUseCase;

  ToDoListCubit({
    required this.toDoListUseCase,
    required this.updateToDoListUseCase,
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
      (l) => _errorHandler(l.errorMessage),
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

  Future<void> updateToDoList(ToDoEntity newItem) async {
    List<ToDoEntity> newToDoList = [];

    newToDoList.addAll(state.toDoList);
    newToDoList.add(newItem);

    final result = await updateToDoListUseCase(newToDoList);

    result.fold(
      (l) => _errorHandler(l.errorMessage),
      (_) {
        emit(
          state.copyWith(
            toDoList: newToDoList,
          ),
        );
      },
    );
  }

  Future<void> removeToDoItem(int index) async {
    List<ToDoEntity> newList = [];

    newList.addAll(state.toDoList);

    newList.removeAt(index);

    final result = await updateToDoListUseCase(newList);

    result.fold(
      (l) => _errorHandler(l.errorMessage),
      (_) {
        emit(
          state.copyWith(
            toDoList: newList,
            isLoading: false,
          ),
        );
      },
    );
  }

  void _errorHandler(String? errorMessage) {
    emit(
      state.copyWith(
        isLoading: false,
        errorMessage: errorMessage ?? '',
      ),
    );
  }
}
