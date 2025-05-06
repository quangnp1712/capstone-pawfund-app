import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'log_account_page_event.dart';
part 'log_account_page_state.dart';

class LogAccountPageBloc extends Bloc<LogAccountPageEvent, LogAccountPageState> {
  LogAccountPageBloc() : super(LogAccountPageInitial()) {
    on<LogAccountPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
