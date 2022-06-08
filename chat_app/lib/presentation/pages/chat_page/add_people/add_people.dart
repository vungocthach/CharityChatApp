import 'package:chat_app/configs/colorconfig.dart';
import 'package:chat_app/domain/entities/user_active_entity.dart';
import 'package:chat_app/presentation/bloc/add_member/add_member_bloc.dart';
import 'package:chat_app/presentation/pages/chat_page/group_name/group_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../configs/fontconfig.dart';
import '../../../../dependencies_injection.dart';
import '../../../bloc/make_name_group/make_name_group_bloc.dart';
import 'component/member.dart';
import 'component/non_member.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({Key? key}) : super(key: key);

  @override
  State<AddPeople> createState() => _AddPeople();
}

class _AddPeople extends State<AddPeople> {
  var _addMemberBloc;
  List<UserActiveEntity> _listMember = [];
  List<UserActiveEntity> _listFriend = [];
  @override
  void initState() {
    super.initState();
    _addMemberBloc = BlocProvider.of<AddMemberBloc>(context);
    _addMemberBloc.add(const AddMemberLoadSuggest(number: 10, startIndex: 0));
    _listFriend = _listMember = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: BlocBuilder<AddMemberBloc, AddMemberState>(
            builder: (context, state) {
          if (state is AddMemberLoadSuccess) {
            _listMember = state.members;
            return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      stretch: true,
                      floating: false,
                      toolbarHeight: state.members.isEmpty ? 80.h : 160.h,
                      automaticallyImplyLeading: false,
                      backgroundColor: cwColorBackground,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60.h,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 15.h),
                              child: Container(
                                height: 40.h,
                                child: TextField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.all(13),
                                        hintText: "Tìm kiếm",
                                        hintStyle: kText15RegularGreyNotetext,
                                        prefixIcon: const Icon(Icons.search))),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: cwColorWhite),
                              ),
                            ),
                          ),
                          state.members.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                          state.members.length,
                                          (index) => Member(
                                            member: state.members[index],
                                            onTap: () => {
                                              _addMemberBloc.add(
                                                  AddMemberRemove(
                                                      listMember:  state.members,
                                                      member:
                                                          state.members[index],
                                                      listFriend:
                                                          state.friendUsers))
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Gợi ý",
                          style: kText13RegularNote,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.friendUsers.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return NonMember(
                                nonmember: state.friendUsers[index],
                                onTap: () {
                                  _addMemberBloc.add(AddMemberAdd(
                                      listMember: state.members,
                                      member: state.friendUsers[index],
                                      listFriend: state.friendUsers));
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ));
          } else {
            return state is AddMemberLoadFail
                ? const Text("Load fail")
                : const Text("Loading");
          }
        }));
  }

  AppBar getAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: cwColorBlackIcon),
      title: const Text(
        "Thêm thành viên ",
      ),
      titleTextStyle: kText20MediumBlack,
      centerTitle: true,
      backgroundColor: cwColorBackground,
      elevation: 0,
      //automaticallyImplyLeading: false,
      actions: [
        TextButton(
          child: Text("Tiếp", style: kText18RegularMain),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => MakeNameGroupBloc(sl()),
                        child: GroupName(
                          listMember: [..._listMember],
                        ),
                      )),
            );
          },
        )
      ],
    );
  }
}
