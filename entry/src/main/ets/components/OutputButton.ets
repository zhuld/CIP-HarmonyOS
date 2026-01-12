import { buttonRadius, gradientAngle, inputColor, shadowRadius } from "../pages/Test/Config"

@ComponentV2
export struct OutputButton {
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Param foreColor: number = 0

  build() {
    Row({ space: this.icon ? 10 : 0 }) {
      Image(this.icon)
        .height(this.icon ? '60%' : 0)
        .aspectRatio(1)
        .fillColor($r('app.color.text_color')) // 根据状态切换颜色
        .draggable(false)
      Text(this.label)
        .fontColor($r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius(buttonRadius)
    .linearGradient({
      angle: gradientAngle,
      colors:
      [[$r('app.color.category_background_1'), 0.1],
        [$r('app.color.category_background_2'), 1.0]]
    })
    .size({ width: '100%', height: '100%' })
    .backgroundColor(Color.Transparent)
    .shadow({
      radius: shadowRadius * 4,
      color: inputColor[this.foreColor],
      fill: false,
    })
  }
}
