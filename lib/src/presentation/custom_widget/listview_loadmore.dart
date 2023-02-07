import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewLoadMoreWidget extends StatefulWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final int itemCount;
  final DragStartBehavior dragStartBehavior;
  final Function funcLoadMore;
  final IndexedWidgetBuilder itemBuilder;
  final Stream<bool> canLoadMore;
  final Stream<bool>? showLoading;

  const ListViewLoadMoreWidget({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.shrinkWrap = false,
    required this.itemBuilder,
    this.itemCount = 0,
    this.dragStartBehavior = DragStartBehavior.start,
    required this.funcLoadMore,
    required this.canLoadMore,
    this.showLoading,
  }) : super(key: key);

  @override
  State<ListViewLoadMoreWidget> createState() => _ListViewLoadMoreWidgetState();
}

class _ListViewLoadMoreWidgetState extends State<ListViewLoadMoreWidget> {
  final ScrollController _scrollController = ScrollController();
  final offsetVisibleThreshold = 10.0;
  bool _canLoad = true;

  @override
  void initState() {
    _scrollController.addListener(execute);
    widget.canLoadMore.listen((event) => _canLoad = event);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            key: widget.key,
            itemBuilder: widget.itemBuilder,
            itemCount: widget.itemCount,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
            dragStartBehavior: widget.dragStartBehavior,
          ),
        ),
        StreamBuilder<bool>(
            stream: widget.showLoading,
            builder: (context, snapshot) => snapshot.hasData && snapshot.data!
                ? SizedBox(
                    height: 30,
                    width: context.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: context.theme.colorScheme.primary),
                      child: Center(
                        child: Text(
                          'Đang tải dữ liệu',
                          style: context.textTheme
                              .apply(bodyColor: context.theme.colorScheme.onPrimary)
                              .bodyMedium,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink())
      ],
    );
  }

  void execute() {
    if (!_canLoad) return;
    if (_scrollController.offset + offsetVisibleThreshold >=
        _scrollController.position.maxScrollExtent) {
      widget.funcLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
