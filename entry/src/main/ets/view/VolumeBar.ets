import { RoundButton } from "./RoundButton"

@Component
export struct  VolumeBar {
  @Prop name: string|Resource
  @Prop mini: number
  @Prop max: number
  @Prop value: number = 0
  @Prop checked: boolean
  private lastValue: number = 0
  @State pressed :boolean = false

  onMuteAction?:(event: TouchEvent) => void
  onVolumeChanged?:(value: number) => void

  build() {
    Column({ space: 10 }) {
      Text(this.name)
        .fontSize(30)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      Text((Math.floor(this.value * (this.max - this.mini) / 65535) + this.mini).toString())
        .fontSize(30)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      Slider({
        min: this.mini,
        max: this.max,
        value: Math.floor(this.value * (this.max - this.mini) / 65535) + this.mini,
        step: 1,
        direction: Axis.Vertical,
        reverse: true,
      })
        .layoutWeight(10)
        .blockColor(this.pressed? $r('app.color.button_checked'):$r('app.color.button'))
        .trackThickness(10) // 设置滑动条粗细为10
        .trackColor($r('app.color.button_checked_light'))
        .selectedColor($r('app.color.button_checked'))
        .showSteps(true)
        .minResponsiveDistance(1)
        .onChange((value: number) => {
          if(this.lastValue !== value) {
            this.lastValue = value
            console.info(`[slider] ${this.lastValue}  ${value}`)
          }else {
            if (this.onVolumeChanged) {
              this.onVolumeChanged(Math.floor((value - this.mini) / (this.max - this.mini) * 65535))
            }
          }
        })
      RoundButton({
        label: '',
        checked : this.checked,
        icon:  this.checked ?$r('app.media.mute') :$r('app.media.unmute')
      })
        .width('70')
        .onTouch((event: TouchEvent) =>{
          if (this.onMuteAction) {
            this.onMuteAction(event)
          }
        })
    }
  }
}