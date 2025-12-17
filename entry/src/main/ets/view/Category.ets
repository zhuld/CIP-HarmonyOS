@Component
export struct Category {
  @Builder  BuilderFunction() {}
  @Prop title: string | Resource ; // 可修改的标题文本
  @Prop icon: Resource;
  @BuilderParam contentBuilder:  () => void = this.BuilderFunction; // 可修改的内容区域

  build() {
    Column({space: 20}) {
      // 标题区域
      Row({space:10}) {
        Image(this.icon)
          .height(this.icon ? '70%' : 0)
          .aspectRatio(1)
          .fillColor($r('app.color.text_color')) // 根据状态切换颜色
        Text(this.title)
          .fontSize(30)
          .maxLines(1)
          .fontColor($r('app.color.text_color'))
      }
      .width('100%')
      .padding({
        top:10,
        bottom:10,
        left:30,
        right:30
      })
      .layoutWeight(1)
      // 内容区域
      Stack() {
        this.contentBuilder()
      }
      .layoutWeight(8)
      .width('100%')
      .padding({
        top:10,
        bottom:10,
        right:20,
        left:20
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