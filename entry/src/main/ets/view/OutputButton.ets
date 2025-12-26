import { gradientAngle } from "../pages/Test/Config"

export const inputColor : Array<ResourceColor> = [
  $r('app.color.tab_button'),
  $r('app.color.input_color_1'),
  $r('app.color.input_color_2'),
  $r('app.color.input_color_3'),
  $r('app.color.input_color_4'),
  $r('app.color.input_color_5'),
  $r('app.color.input_color_6'),
  $r('app.color.input_color_7'),
  $r('app.color.input_color_8'),
]
@ComponentV2
export struct OutputButton {
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Param foreColor: number = 0

  build() {
    Row({space:this.icon? 10:0}) {
      Image(this.icon)
        .height(this.icon ? '60%' : 0)
        .aspectRatio(1)
        .fillColor($r('app.color.text_color')) // 根据状态切换颜色
      Text(this.label)
        .fontColor($r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius("5%")
    .linearGradient({
      angle: gradientAngle,
      colors:
      [ [$r('app.color.tab_button_light'), 0.1],
        [inputColor[this.foreColor], 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .shadow({
      radius: 15,
      color:  ColoringStrategy.AVERAGE, //  $r('app.color.shadow_color'),
      fill: false,
      offsetX: 5,
      offsetY: 6
    })
  }
}
