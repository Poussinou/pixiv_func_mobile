import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixiv_dart_api/enums.dart';
import 'package:pixiv_func_mobile/app/i18n/i18n.dart';
import 'package:pixiv_func_mobile/components/sliding_segmented_control/sliding_segmented_control.dart';
import 'package:pixiv_func_mobile/models/bookmarked_filter.dart';

class BookmarkedFilterEditor extends StatelessWidget {
  final BookmarkedFilter filter;

  const BookmarkedFilterEditor({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<BookmarkedFilter>>(
      (Rx<BookmarkedFilter> data) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SlidingSegmentedControl(
                children: <Restrict, Widget>{
                  Restrict.public: Text(I18n.public.tr),
                  Restrict.private: Text(I18n.private.tr),
                },
                groupValue: data.value.restrict,
                onValueChanged: (Restrict? value) {
                  if (null != value) {
                    data.update((val) {
                      val?.restrict = value;
                    });
                  }
                },
                splitEqually: false,
              )
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back(result: data.value);
              },
              child: Text(I18n.confirm.tr),
            ),
          ],
        );
      },
      BookmarkedFilter.copy(filter).obs,
    );
  }
}
