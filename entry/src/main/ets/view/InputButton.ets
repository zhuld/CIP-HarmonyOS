@Component
export struct InputButton {
  private  gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource
  @Prop fontSize: number = 20
  @Prop foreColor: ResourceColor = $r('app.color.button')
  @State checked: boolean = false
  @State opacityValue: number = 1
  onDragAction?:(start: boolean) => void

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
        [this.foreColor, 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked ? 3 : 0
    })
    .shadow({
      radius: this.checked ? 8 : 15,
      color:  ColoringStrategy.AVERAGE, //  $r('app.color.shadow_color'),
      fill: true,
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .opacity(this.opacityValue)
    .animation({
      duration: 100,
      curve: Curve.EaseInOut,
    })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.checked = true;
      } else {
        this.checked = false
      }
    })
    .draggable(true)
    .onDragStart(() => {
      if(this.onDragAction){
        this.onDragAction(true)
        this.opacityValue = 0.2
      }
    })
    .onDragEnd(() => {
      if(this.onDragAction){
        this.onDragAction(false)
        this.opacityValue = 1
      }
    })
  }
}
