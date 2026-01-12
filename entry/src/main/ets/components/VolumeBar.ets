import { RoundButton } from "./RoundButton"

@ComponentV2
export struct  VolumeBar {
  @Param name: string | Resource | undefined = undefined
  @Param min: number = 0
  @Param max: number = 100
  @Param value: number = 0
  @Param muteChecked: boolean = false
  @Param plusChecked: boolean = false
  @Param minusChecked: boolean = false
  private lastValue: number = 0
  @Event onMuteAction?: (event: TouchEvent) => void
  @Event onPlusAction?: (event: TouchEvent) => void
  @Event onMinusAction?: (event: TouchEvent) => void
  @Event onVolumeChanged?: (value: number) => void

  build() {
    Column({ space: 0 }) {
      Text(this.name)
        .fontSize(30)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      Text((Math.floor(this.value * (this.max - this.min) / 65535) + this.min).toString())
        .fontSize(30)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      Row({ space: 10 }) {
        Slider({
          min: this.min,
          max: this.max,
          value: Math.floor(this.value * (this.max - this.min) / 65535) + this.min,
          step: 1,
          direction: Axis.Vertical,
          reverse: true,
        })
          .blockColor($r('app.color.button_light'))
          .trackThickness(10) // 设置滑动条粗细为10
          .trackColor(
            new LinearGradient([
              { color: $r('sys.color.warning'), offset: 1.0 },
              { color: $r('sys.color.alert'), offset: 0.9 },
              { color: $r('sys.color.confirm'), offset: 0.7 }
            ])
          )
          .selectedColor($r('app.color.button'))
          .stepSize(1)
          .minResponsiveDistance(1)
          .height('95%')
          .layoutWeight(2)
          .blockSize({
            width: 50,
            height: 50
          })
          .onChange((value: number) => {
            if (this.lastValue !== value) {
              this.lastValue = value
            } else {
              if (this.onVolumeChanged) {
                this.onVolumeChanged(Math.floor((value - this.min) / (this.max - this.min) * 65535))
              }
            }
          })
        Column({ space: 10 }) {
          RoundButton({
            checked: this.plusChecked,
            icon: $r('app.media.zoomin')
          })
            .width('70')
            .onTouch((event: TouchEvent) => {
              if (this.onPlusAction) {
                this.onPlusAction(event)
              }
            })
          RoundButton({
            checked: this.minusChecked,
            icon: $r('app.media.zoomout')
          })
            .width('70')
            .onTouch((event: TouchEvent) => {
              if (this.onMinusAction) {
                this.onMinusAction(event)
              }
            })
          RoundButton({
            checked: this.muteChecked,
            icon: this.muteChecked ? $r('app.media.mute') : $r('app.media.unmute')
          })
            .width('70')
            .onTouch((event: TouchEvent) => {
              if (this.onMuteAction) {
                this.onMuteAction(event)
              }
            })
        }
        .height('100%')
        .layoutWeight(3)
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .layoutWeight(10)
    }
  }
}