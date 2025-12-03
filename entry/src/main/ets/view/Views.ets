import { unifiedDataChannel } from "@kit.ArkData"

@Component
export struct NormalButton {
  private  gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource
  @Prop fontSize: number = 20
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    Row({space:this.icon? 10:0}) {
      Image(this.icon)
        .height(this.icon ? '60%' : 0)
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    .onTouch((event: TouchEvent) =>{
      if (this.onTouchAction) {
        this.onTouchAction(event)
      }
    })
    .justifyContent(FlexAlign.Center)
    .borderRadius("5%")
    .linearGradient({
      angle: this.gradientAngle,
      colors: this.checked ?
        [ [$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]]:
        [ [$r('app.color.button_light'), 0.1],
          [$r('app.color.button'), 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked  ? 3 : 0
    })
    .shadow({
      radius: this.checked  ? 8 : 15,
      color: $r('app.color.shadow_color'),
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: 100,
      curve: Curve.EaseInOut
    })
  }
}

@Component
export struct InputButton {
  private  gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource
  @Prop fontSize: number = 20
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    Row({space:this.icon? 10:0}) {
      Image(this.icon)
        .height(this.icon ? '60%' : 0)
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    // .onTouch((event: TouchEvent) =>{
    //   if (this.onTouchAction) {
    //     this.onTouchAction(event)
    //   }
    // })
    .justifyContent(FlexAlign.Center)
    .borderRadius("5%")
    .linearGradient({
      angle: this.gradientAngle,
      colors: this.checked ?
        [ [$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]]:
        [ [$r('app.color.button_light'), 0.1],
          [$r('app.color.button'), 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked  ? 3 : 0
    })
    .shadow({
      radius: this.checked  ? 8 : 15,
      color: $r('app.color.shadow_color'),
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: 100,
      curve: Curve.EaseInOut
    })
    .draggable(true).onDragStart((event) => {
      event.setData(new unifiedDataChannel.UnifiedData());
      console.info(`[drag] start `)
    });
  }
}

@Component
export struct MyButton {
  private gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource
  @Prop fontSize: number = 20
  @Prop checked: boolean = false

  build() {
    Row({ space: this.icon ? 5 : 0 }) {
      Image(this.icon)
        .width(this.icon ? this.fontSize : 0)
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.checked = true;
      } else if (event.type === TouchType.Up) {
        this.checked = false
      }
    })
    .justifyContent(FlexAlign.Center)
    .borderRadius("5%")
    .linearGradient({
      angle: this.gradientAngle,
      colors: this.checked ?
        [[$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]] :
        [[$r('app.color.button_light'), 0.1],
          [$r('app.color.button'), 1.0]]
    })
    .size({ width: '100%', height: '100%' })
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked ? 3 : 0
    })
    .shadow({
      radius: this.checked ? 8 : 15,
      color: $r('app.color.shadow_color'),
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: 100,
      curve: Curve.EaseInOut
    })
  }
}
@Component
export struct RoundButton {
  private gradientAngle: number = 40
  @Prop label: string | Resource = ''
  @Prop icon: Resource | undefined = undefined
  @Prop fontSize: number = 20
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    RelativeContainer() {
      Stack() {
        Image(this.icon)
          .width('50%')
          .aspectRatio(1)
          .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
      }
      .onTouch((event: TouchEvent) =>{
        if (this.onTouchAction) {
          this.onTouchAction(event)
        }
      })
      .width('100%')
      .aspectRatio(1)
      .borderRadius('50%')
      .backgroundColor(Color.Transparent)
      .linearGradient({
        angle: this.gradientAngle,
        colors: this.checked ?
          [[$r('app.color.button_checked_light'), 0.1],
            [$r('app.color.button_checked'), 1.0]] :
          [[$r('app.color.button_light'), 0.1],
            [$r('app.color.button'), 1.0]]
      })
      .shadow({
        radius: this.checked ? 8 : 15,
        color: $r('app.color.shadow_color'),
        offsetX: this.checked ? 2 : 5,
        offsetY: this.checked ? 3 : 6
      })
      .margin({
        top: this.checked ? 3 : 0,
        left: this.checked ? 3 : 0
      })
      .animation({
        duration: 100,
        curve: Curve.EaseInOut
      })

      Text(this.label)
        .fontColor($r('app.color.text_color'))
        .fontSize(this.fontSize)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .width('100%')
        .alignRules({
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        })
    }
    .width('100%')
    .aspectRatio(0.75)
  }
}

@Component
export struct IconButton {
  @Prop icon: Resource | undefined = undefined
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    Row({space:5}) {
      Image(this.icon)
        .width('100%')
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.button_checked'):$r('app.color.button')) // 根据状态切换颜色
    }
    .onTouch((event: TouchEvent) =>{
      if (this.onTouchAction) {
        this.onTouchAction(event)
      }
    })
    .justifyContent(FlexAlign.Center)
    .size({ width: '100%', height: '100%'})
  }
}

@Component
export struct  VolumeBar {
  @Prop name: string|Resource
  @Prop mini: number
  @Prop max: number
  @Prop value: number = 0
  @Prop checked: boolean
  private lastValue: number = 0

  @State onPressed :boolean = false

  onTouchAction?:(event: TouchEvent) => void
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
        .blockColor($r('app.color.button'))
        .trackThickness(10) // 设置滑动条粗细为10.showTips(false) // 关闭默认提示
        .trackColor($r('app.color.button_checked_light'))
        .selectedColor($r('app.color.button_checked'))
        .showSteps(true)
        .minResponsiveDistance(1)
        .onChange((value: number) => {
          if(this.lastValue !== value) {
            this.lastValue = value
          }else {
            if (this.onVolumeChanged) {
              this.onVolumeChanged(Math.floor((value - this.mini) / (this.max - this.mini) * 65535))
            }
          }
        })
      RoundButton({
        label: '',
        checked : this.checked,
        icon: $r('app.media.mute')
      })
        .width('70')
        .onTouch((event: TouchEvent) =>{
          if (this.onTouchAction) {
            this.onTouchAction(event)
          }
        })
    }
  }
}

@Component
export struct TabButton {
  @Prop label: string | Resource = 'Press Me'
  @Prop icon: Resource | undefined
  @Prop fontSize: number = 20
  @Prop checked: boolean = false
  @Prop isEnabled: boolean = true
  onTouchAction?: (event: TouchEvent) => void

  build() {
    SquareButton({
      label: this.label,
      icon: this.icon,
      fontSize: this.fontSize,
      checked: this.checked
    })
      .onTouch((event: TouchEvent) => {
        if (this.onTouchAction && this.isEnabled) {
          this.onTouchAction(event)
        }
      })
      //.visibility(this.isEnabled? Visibility.Visible: Visibility.Hidden)
  }
}

@Component
export struct SquareButton {
  private  gradientAngle: number = 40
  @Prop label: string |Resource = 'Press Me'
  @Prop icon: Resource | undefined
  @Prop fontSize: number = 20
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    Column() {
      Image(this.icon)
        .width('50%')
        .height(this.icon? this.width: 0)
        //.aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check'):$r('app.color.text_color')) // 根据状态切换颜色
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check'):$r('app.color.text_color'))
        .fontSize(this.label === ''? 0: this.fontSize)
        .maxLines(1)
    }
    .onTouch((event: TouchEvent) =>{
      if (this.onTouchAction) {
        this.onTouchAction(event)
      }
    })
    .justifyContent(FlexAlign.Center)
    .borderRadius("15%")
    .linearGradient({
      angle: this.gradientAngle,
      colors: this.checked ?
        [ [$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]]:
        [ [$r('app.color.tab_button_light'), 0.1],
          [$r('app.color.tab_button'), 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked  ? 3 : 0
    })
    .shadow({
      radius: this.checked  ? 8 : 15,
      color: $r('app.color.shadow_color'),
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: 100,
      curve: Curve.EaseInOut
    })
    .aspectRatio(1)
  }
}
@Component
export struct Category {
  @Builder  BuilderFunction() {}
  @Prop title: string = "默认标题"; // 可修改的标题文本
  @BuilderParam contentBuilder:  () => void = this.BuilderFunction; // 可修改的内容区域

  build() {
    Column({space: 20}) {
      // 标题区域
      Text(this.title)
        .fontSize(30)
        .margin(10)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      // 内容区域
      Stack() {
        this.contentBuilder()
      }
      .layoutWeight(8)
      .width('100%')
      .padding({
        top:10,bottom:10,
        right:20,left:20
      })
      .alignContent(Alignment.Top)
    }
    .height('100%')
    .width('100%')
    .borderRadius(30)
    .backgroundColor(Color.Transparent)
    .linearGradient({
      colors:[
        [$r('app.color.catalog_background_1'), 0.0],
        [$r('app.color.catalog_background_2'), 0.1],
        [$r('app.color.catalog_background_3'), 0.1],
        [$r('app.color.catalog_background_2'), 0.14]
      ]
    })
    .shadow({
      radius:  15,
      color:  $r('app.color.shadow_color'),
      offsetX:  8,
      offsetY:  10
    })
  }
}