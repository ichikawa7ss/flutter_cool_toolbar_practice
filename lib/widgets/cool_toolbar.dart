import 'package:flutter/material.dart';
import 'package:flutter_cool_toolbar_practice/model/constants.dart';
import 'package:flutter_cool_toolbar_practice/model/items.dart';
import 'package:flutter_cool_toolbar_practice/widgets/toolbar_item.dart';

class CoolToolbar extends StatefulWidget {
  const CoolToolbar({Key? key}) : super(key: key);

  @override
  _CoolToolbarState createState() => _CoolToolbarState();
}

class _CoolToolbarState extends State<CoolToolbar> {
  // late: 遅延初期化可能なことを示すプロパティ
  late ScrollController scrollController;

  /// アイテム1つの高さ
  ///
  /// 幅と同じものになる
  double get itemHeight =>
      Constants.toolbarWidth - (Constants.toolbarHorizontalPadding * 2);

  /// アイテムのスケールの尺度の配列
  List<double> itemScrollScaleValues = [];

  // TODO 中身を確認
  List<bool> longPressedItemsFlags = [];

  /// 外枠に対するアイテムごとの上端の位置
  List<double> itemYPositions = [];

  void scrollListener() {
    // scrollControllerがscrollViewにアタッチされているかを確認
    if (scrollController.hasClients) {
      _updateItemsScrollData(
        scrollPosition: scrollController.position.pixels,
      );
    }
  }

  /// 現在のスクロール位置に応じてスケールの量とアイテムの位置を決定する
  ///
  /// 内部で [itemScrollScaleValues] と [itemYPositions] が更新される
  void _updateItemsScrollData({double scrollPosition = 0}) {
    List<double> _itemScrollScaleValues = [];
    List<double> _itemYPositions = [];
    for (int i = 0; i <= toolbarItems.length - 1; i++) {
      // スクロールがない状態のアイテムの上端のY座標
      double itemTopPosition = i * (itemHeight + Constants.itemsGutter);

      // 親viewに対するY座標：スクロールがない状態のY座標から、スクロール量を引いた値
      _itemYPositions.add(itemTopPosition - scrollPosition);

      // Difference between the position of the top edge of the item
      // and the position of the bottom edge of the toolbar container plus scroll position
      // A negative value means that the item is out of view below the toolbar container
      double distanceToMaxScrollExtent =
          Constants.toolbarHeight + scrollPosition - itemTopPosition;

      // スクロールがない状態のアイテムの上端のY座標
      double itemBottomPosition =
          (i + 1) * (itemHeight + Constants.itemsGutter);
      // アイテムがスクロールビューの外にあることを示す
      // 上にはみ出す条件；スクロール量がアイテムの下端を超える
      // 下にはみ出す条件；distanceToMaxScrollExtentが負
      bool itemIsOutOfView =
          distanceToMaxScrollExtent < 0 || scrollPosition > itemBottomPosition;

      _itemScrollScaleValues.add(itemIsOutOfView ? 0.4 : 1);
    }

    // 最後にstateの更新をクラスに伝える
    setState(() {
      itemScrollScaleValues = _itemScrollScaleValues; // スケール量
      itemYPositions = _itemYPositions; // 位置
    });
  }

  /// Updates [longPressedItemsFlags] based on the location of the long press event
  ///
  /// Should be called whenever a long-press related event happens
  /// e.g. Long press started, ended, cancelled, moved while pressed, ...etc.
  void _updateLongPressedItemsFlags({double longPressYLocation = 0}) {
    List<bool> _longPressedItemsFlags = [];
    // TODO 中身わかってないのでコード読む
    // for (int i = 0; i <= toolbarItems.length - 1; i++) {
    //   // An item is long pressed if the long press y location is larger than the current
    //   // item's top edge position and smaller than the next items top edge position
    //   // If there is no next item, the long press y location should be smaller
    //   // than the scrollable area (the height of the toolbar_
    //   bool isLongPressed = itemYPositions[i] >= 0 &&
    //       longPressYLocation > itemYPositions[i] &&
    //       longPressYLocation <
    //           (itemYPositions.length > i + 1
    //               ? itemYPositions[i + 1]
    //               : Constants.toolbarHeight);
    //   _longPressedItemsFlags.add(isLongPressed);
    // }
    // setState(() {
    //   longPressedItemsFlags = _longPressedItemsFlags;
    // });
  }

  @override
  void initState() {
    super.initState();
    _updateItemsScrollData();
    _updateLongPressedItemsFlags();
    scrollController = ScrollController();
    // スクロールを検知したときにscrollListener()が呼ばれる
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.toolbarHeight,
      margin: const EdgeInsets.only(left: 20, top: 90),

      /// Stack: z方向に重ねるコンポーネント
      /// Stackを使うと他のWidgetの位置関係に影響を受けずに、リスト型のコンポーネントを配置可能
      child: Stack(
        children: [
          /// フローティングの外枠
          /// 座標指定の間隔で絶対的な位置にWidgetを配置したい方は`Positioned`を使うとよい
          Positioned(
            child: Container(
              width: Constants.toolbarWidth,

              /// BoxDecorationは箱型のUIを提供するコンポーネント
              /// 主にボーダー、ボディを持っている
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
              ),
            ),
          ),

          /// タッチイベントを取得できるWidget
          /// ListViewをくくってロングプレスを検知する
          /// 検知できるイベント自体はいっぱいある
          GestureDetector(
            onLongPressStart: (LongPressStartDetails details) {
              // ロングプレス開始時にコール
            },
            onLongPressMoveUpdate: (details) {
              // ロングプレス状態での移動で位置が変化した時にコール
            },
            onLongPressEnd: (LongPressEndDetails details) {
              // ロングプレス完了時にコール
            },
            onLongPressCancel: () {
              // ロングプレスキャンセル時にコール
            },
            child: ListView.builder(

                /// ListViewのcontrollerにscrollControllerを割り当てると
                controller: scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: toolbarItems.length,

                /// itemBuilderでi番目の要素のWidgetを定義する
                /// itemCountで個数を制御する
                /// c: context
                /// i: index
                itemBuilder: (c, i) => ToolbarItem(
                      toolbarItems[i],
                      height: itemHeight,
                      scrollScale: itemScrollScaleValues[i],
                      isLongPressed: longPressedItemsFlags[i],
                    )),
          )
        ],
      ),
    );
  }
}
