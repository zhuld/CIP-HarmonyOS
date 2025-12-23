import { SquareButton } from "./SquareButton";

@ComponentV2
export struct Category {
  @Builder
  BuilderFunction() {
  }
  @Param title: string | Resource = ''; // 可修改的标题文本
  @Param subTitle: string | Resource = ''; // 可修改的副标题文本
  @Param icon: Resource | undefined = undefined;
  @Param checked: boolean = false;
  @Param checkButton: boolean = false;
  @BuilderParam contentBuilder: () => void = this.BuilderFunction; // 可修改的内容区域
  @Event onTouchAction?:(event: TouchEvent) => void

  build() {
    Column({ space: 10 }) {
      // 标题区域
      Row() {
        Row({ space: 10 }) {
          Image(this.icon)
            .height(this.icon ? '70%' : 0)
            .aspectRatio(1)
            .fillColor($r('app.color.text_color')) // 根据状态切换颜色
          Text(this.title)
            .fontSize(30)
            .maxLines(1)
            .fontColor($r('app.color.text_color'))
        }

        Row({ space: 10 }) {
          SquareButton({
            checked: this.checked,
            icon: this.checked ? $r('app.media.check') : undefined,
            onTouchAction: (event: TouchEvent) => {
                if (this.onTouchAction) {
                  this.onTouchAction(event)
                }
            }
          })
            .width(30)
            .visibility(this.checkButton? Visibility.Visible : Visibility.None)
          Text(this.subTitle)
            .fontSize(26)
            .maxLines(1)
            .fontColor($r('app.color.subTitle_color'))
        }
      }
      .justifyContent(this.subTitle ? FlexAlign.SpaceBetween : FlexAlign.Center)
      .width('100%')
      .padding({
        top: 10,
        bottom: 20,
        left: 30,
        right: 30
      })
      .layoutWeight(1)

      // 内容区域
      Stack() {
        this.contentBuilder()
      }
      .layoutWeight(7)
      .width('100%')
      .padding({
        top: 10,
        bottom: 10,
        right: 20,
        left: 20
      })
      .alignContent(Alignment.Top)
    }
    .height('100%')
    .width('100%')
    .borderRadius(30)
    .backgroundColor(Color.Transparent)
    .linearGradient({
      colors: [
        [$r('app.color.catalog_background_1'), 0.1],
        [$r('app.color.catalog_background_2'), 0.1],
        [$r('app.color.catalog_background_1'), 0.12]
      ]
    })
    .shadow({
      radius: 15,
      color:  ColoringStrategy.AVERAGE, //  $r('app.color.shadow_color'),
      fill: true,
      offsetX: 10,
      offsetY: 12,
    })
  }
}