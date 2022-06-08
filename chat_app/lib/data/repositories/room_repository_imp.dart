import 'dart:convert';
import 'dart:io';

import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/room_overview_entity.dart';
import 'package:chat_app/domain/repositories/room_repository.dart';
import 'package:chat_app/helper/constant.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/utils/local_storage.dart';
import 'package:http/http.dart' as http;

import '../../dependencies_injection.dart';
import '../../helper/network/network_info.dart';
import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasource.dart';

class RoomRepositoryImp implements IRoomRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  static const _roomUrl = serverUrl + "/rooms";
  static const _roomSelectUrl = RoomRepositoryImp._roomUrl + "/select";
  static const _roomCreatUrl = RoomRepositoryImp._roomUrl + "/create";

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
  Future<bool> create(RoomEntity room, File? avatar) async {
    try {
      final _token = await sl<LocalStorageService>().getToken();
      if (_token != null) {
        final _uri = Uri.http(serverUrl, "/rooms/create",);
        final _request = http.MultipartRequest("POST", _uri);
        _request.headers.addAll({'token': _token});

        _request.fields["name"] = room.name;
        _request.fields["joinersId"] = getListIdFromListUser(room.users);
        _request.fields["typeRoom"] = room.typeRoom;
        if (avatar != null) {
          _request.files.add(
              http.MultipartFile.fromBytes('image', avatar.readAsBytesSync()));
        }
        final _response = await _request.send();

        if (_response.statusCode == 200) {
          return true;
        } else {
          _response.stream.transform(utf8.decoder).listen((event) {
            print('Create Chat Room error: ' + event);
          });
          return false;
        }
      }
      else{
        print("User must register");
      }
    } catch (e) {}

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
      String userId, int startIndex, int number, String searchtype) async {
    final queryParameters = {
      'userId': userId.toString(),
      'startIndex': startIndex.toString(),
      'number': number.toString(),
      'orderby': 'timeCreate',
      'orderdirection': 'desc',
      'searchby': 'name',
      'searchvalue': null,
      'searchtype': searchtype
    };
    final token = await sl<LocalStorageService>().getToken();
    if (token == null) throw Exception('Token required');
    
    final _uri = Uri.http(serverUrl, "/rooms/select", queryParameters);
    print(_uri);
    final response = await http.get(_uri, headers: {"token": token});
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body)["rooms"] as List<dynamic>;
      print(json);
      final listRoomOverviews =
          jsonRes.map((x) => RoomOverviewEntity.fromJson(x)).toList();
      return listRoomOverviews;
    } else {
      print("Error load list OverviewRooms: ");
      throw response;
    }
  }
}
