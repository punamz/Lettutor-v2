import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/src/presentation/custom_widget/listview_loadmore.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/tutor/child_widget/tutor_card_widget.dart';
import 'package:lettutor/src/presentation/page/tutor/tutor_ctrl.dart';

class TutorView extends GetView<TutorController> {
  static const String routeName = '/TutorView';
  const TutorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutor')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) => controller.onSearchChange(value),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search Tutor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: Specialty.values.length,
                itemBuilder: (context, index) {
                  Specialty spec = Specialty.values[index];
                  return Obx(() => ChoiceChip(
                        label: Text(spec.description),
                        selected: controller.specialty.value == spec,
                        onSelected: (selected) {
                          if (selected) controller.selectSpecialty(spec);
                        },
                      ));
                },
                separatorBuilder: (context, index) => const SizedBox(width: 5),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => controller.isGettingData.value
                ? const Center(child: LoadingWidget())
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: controller.refreshData,
                      child: Obx(
                        () => controller.tutors.isNotEmpty
                            ? Obx(() => ListViewLoadMoreWidget(
                                  itemCount: controller.tutors.length,
                                  itemBuilder: (context, index) =>
                                      TutorCardWidget(tutor: controller.tutors[index]),
                                  funcLoadMore: controller.loadMoreTutor,
                                  showLoading: controller.isLoadingMore.stream,
                                  canLoadMore: controller.canLoadMore.stream,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                ))
                            : Stack(
                                children: [
                                  ListView(),
                                  Center(
                                    child: Text(
                                      'Oops!!!\nThere is no teacher',
                                      style: context.textTheme.titleMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
