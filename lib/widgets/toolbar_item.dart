import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cool_toolbar_practice/model/constants.dart';
import 'package:flutter_cool_toolbar_practice/model/toolbar_item_data.dart';

class ToolbarItem extends StatelessWidget {
  ToolbarItem(
    this.toolbarItem, {
    required this.height,
    required this.scrollScale,
    this.isLongPressed = false,
    this.gutter = 10,
    Key? key,
  }) : super(key: key);

  final ToolbarItemData toolbarItem;
  final double height;
  final double scrollScale;
  final bool isLongPressed;

  /// アイテム間の距離
  final double gutter;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      // SizedBoxは厳密にサイズを指定したい場合に使う
      child: SizedBox(
        height: height + gutter,
        child: Stack(
          children: [
            // TODO: 一旦入れたけど中身わかってないので修正する
            /// - AnimatedScale:
            /// 与えられたスケールが変更されるたびに、
            /// 与えられた期間にわたって自動的に子のスケールを遷移する
            /// Transform.scaleのアニメーションバージョン
            AnimatedScale(
              scale: scrollScale, // アイテムの拡縮
              duration: Constants.scrollScaleAnimationDuration,
              curve: Constants.scrollScaleAnimationCurve,
              child: AnimatedContainer(
                duration: Constants.longPressAnimationDuration,
                curve: Constants.longPressAnimationCurve,
                height: height + (isLongPressed ? 10 : 0),
                width: isLongPressed ? Constants.toolbarWidth * 2 : height,
                decoration: BoxDecoration(
                  color: toolbarItem.color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  bottom: gutter,
                  left: isLongPressed ? Constants.itemsOffset : 0,
                ),
              ),
            ),

            /// アイコン画像
            /// こちらもアニメーションする
            Positioned.fill(
              child: AnimatedPadding(
                duration: Constants.longPressAnimationDuration,
                curve: Constants.longPressAnimationCurve,
                padding: EdgeInsets.only(
                  bottom: gutter,
                  left: 12 + (isLongPressed ? Constants.itemsOffset : 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedScale(
                      scale: scrollScale,
                      duration: Constants.scrollScaleAnimationDuration,
                      curve: Constants.scrollScaleAnimationCurve,
                      child: Icon(
                        toolbarItem.icon,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
