import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/chat/domain/entities/chat_room_entity.dart';
import 'package:neurocare_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatRoomsUseCase
    implements UseCase<List<ChatRoomEntity>, GetChatRoomsParams> {
  final ChatRepository repository;

  GetChatRoomsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> call(
      GetChatRoomsParams params) {
    return repository.getChatRooms();
  }
}

class GetChatRoomsParams extends Equatable {
  const GetChatRoomsParams();

  @override
  List<Object?> get props => [];
}
