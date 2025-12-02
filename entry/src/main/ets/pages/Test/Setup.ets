@Component
export struct SetupComponent{
  build() {
    Column() {
      Text('设备控制')
        .fontSize(20)
      // 添加新闻列表...
    }
    .width('100%')
    .height('100%')
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}