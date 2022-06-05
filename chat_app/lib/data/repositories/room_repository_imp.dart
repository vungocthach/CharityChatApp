import 'dart:convert';

import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/room_overview_entity.dart';
import 'package:chat_app/domain/repositories/room_repository.dart';
import 'package:chat_app/helper/constant.dart';
import 'package:http/http.dart' as http;

import '../../helper/network/network_info.dart';
import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasource.dart';

class RoomRepositoryImp implements IRoomRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  static const _roomUrl = serverUrl + "/rooms";
  static const _roomSelectUrl = RoomRepositoryImp._roomUrl + "/select";

  RoomRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<bool> addUser(String roomId, String userId) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<bool> changeAvatar(String roomId, String avatarData) {
    // TODO: implement changeAvatar
    throw UnimplementedError();
  }

  @override
  Future<bool> changeName(String roomId, String newName) {
    // TODO: implement changeName
    throw UnimplementedError();
  }

  @override
  Future<bool> create(RoomEntity room) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String roomId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<RoomEntity>> findRoomsByName(String textMatch) {
    // TODO: implement findRoomsByName
    throw UnimplementedError();
  }

  @override
  Future<List<RoomEntity>> getRooms(int startIndex, int number) {
    // TODO: implement getRooms
    throw UnimplementedError();
  }

  @override
  Future<bool> removeUser(String roomId, String userId) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<List<RoomOverviewEntity>> getRoomOverviews(
      int userId, int startIndex, int number) async {
    final queryParameters = {
      'userId': userId.toString(),
      'startIndex': startIndex.toString(),
      'number': number.toString(),
      'orderby': 'createTime',
      'orderdirection': 'desc',
      'searchby': 'name',
      'searchvalue': "Phòng"
    };
    final _uri = Uri.http(serverUrl, "/rooms/select", queryParameters);
    print(_uri);
    final response = await http.get(_uri, headers: {"token": 'ADMIN_TOKEN'});
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body)["rooms"] as List<dynamic>;
      final listRoomOverviews =
          jsonRes.map((x) => RoomOverviewEntity.fromJson(x)).toList();
      return listRoomOverviews;
    } else {
    print("Error load list OverviewRooms: ");
    throw response;
    }
  }
}
