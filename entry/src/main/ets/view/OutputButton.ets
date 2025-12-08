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
@Component
export struct OutputButton {
  private  gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource
  @Prop fontSize: number = 20
  @Prop foreColor: number = 0

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
      angle: this.gradientAngle,
      colors:
      [ [$r('app.color.tab_button_light'), 0.1],
        [inputColor[this.foreColor], 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .shadow({
      radius: 15,
      color: $r('app.color.shadow_color'),
      offsetX: 5,
      offsetY: 6
    })
  }
}
