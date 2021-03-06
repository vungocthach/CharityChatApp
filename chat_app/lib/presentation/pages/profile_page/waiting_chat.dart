import 'package:chat_app/configs/colorconfig.dart';
import 'package:chat_app/configs/fontconfig.dart';
import 'package:chat_app/dataexample/active_user.dart';
import 'package:chat_app/dataexample/shortchat.dart';
import 'package:chat_app/domain/entities/room_overview_entity.dart';
import 'package:chat_app/presentation/pages/chat_page/chatpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitingChat extends StatelessWidget {
  const WaitingChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "5 tin nhắn chờ  ",
                  style: ktext17RegularGreyText,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ShortChat(
                    roomOverview: RoomOverviewEntity(
                        id: "1",
                        name: "Nhực",
                        lastMessage: null,
                        avatarUrl: null,
                        type: 'private',
                        joiners: []),
                  );
                }),
          ]),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: cwColorBackground,
      elevation: 0,
      iconTheme: const IconThemeData(color: cwColorBlackIcon),
      centerTitle: true,
      toolbarHeight: 70.h,
      title: Text(
        "Tin nhắn chờ ",
        style: kText20MediumBlack,
      ),
    );
  }
}
