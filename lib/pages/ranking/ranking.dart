import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv_dart_api/enums.dart';
import 'package:pixiv_func_mobile/app/data/data_tab_config.dart';
import 'package:pixiv_func_mobile/app/data/data_tab_page.dart';
import 'package:pixiv_func_mobile/app/i18n/i18n.dart';
import 'package:pixiv_func_mobile/components/illust_previewer/illust_previewer.dart';

import 'content/source.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key? key}) : super(key: key);

  static final tabNames = [
    I18n.day.tr,
    I18n.dayR18.tr,
    I18n.dayMale.tr,
    I18n.dayMaleR18.tr,
    I18n.dayFemale.tr,
    I18n.dayFemaleR18.tr,
    I18n.week.tr,
    I18n.weekR18.tr,
    I18n.weekOriginal.tr,
    I18n.weekRookie.tr,
    I18n.month.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DataTabPage(
          title: 'Pixiv Func',
          tabs: [
            for (int index = 0; index < tabNames.length; ++index)
              DataTabConfig(
                name: tabNames[index],
                source: RankingListSource(RankingMode.values[index]),
                itemBuilder: (BuildContext context, item, int index) => IllustPreviewer(illust: item),
                extendedListDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              ),
          ],
          isScrollable: true,
        ),
      ),
    );
  }
}
