import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cool_toolbar_practice/model/constants.dart';

class CoolToolbar extends StatefulWidget {
  const CoolToolbar({Key? key}) : super(key: key);

  @override
  _CoolToolbarState createState() => _CoolToolbarState();
}

class _CoolToolbarState extends State<CoolToolbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.toolbarHeight,
      margin: const EdgeInsets.only(left: 20, top: 90),
      // Stack: z方向に重ねるコンポーネント
      // Stackを使うと他のWidgetの位置関係に影響を受けずに、リスト型のコンポーネントを配置可能
      child: Stack(
        children: [
          // 座標指定の間隔で絶対的な位置にWidgetを配置したい方は`Positioned`を使うとよい
          Positioned(
            child: Container(
              width: Constants.toolbarWidth,
              // BoxDecorationは箱型のUIを提供するコンポーネント
              // 主にボーダー、ボディを持っている
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
          // タッチイベントを取得できるWidget
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
            child: Text('test'),
          )
        ],
      ),
    );
  }
}
