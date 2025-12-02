import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../model/Models'
import { Category, NormalButton } from '../../view/Views'
import { Test_Setup } from './Config'

@Component
export struct SetupComponent {
  @ObjectLink crestronClient: CrestronClient
  @Consume channelDArray: boolean[] = []
  @Consume channelAArray: boolean[] = []

  @Builder
  SetupContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
    }) {
      ForEach(buttonList, (item: ButtonModel, index) => {
        if (buttonList[index].buttonId === 0) {
          GridCol({ span: 2 }) {
            Text(item.buttonName)
              .fontSize(32)
              .fontColor($r('app.color.text_color'))
          }
        } else {
          GridCol({ span: 1 }) {
            NormalButton({
              label: item.buttonName,
              icon: item.buttonIcon,
              fontSize: 30,
              checked: this.channelDArray[item.buttonId],
              onTouchAction: (event: TouchEvent) => {
                if (event.type === TouchType.Down) {
                  this.crestronClient?.push(item.buttonId)
                } else if (event.type === TouchType.Up) {
                  this.crestronClient?.release(item.buttonId)
                }
              }
            }).height(80)
          }
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 20, left: 20 })
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row({ space: 30 }) {
      Category({
        title: '设备开关', // 动态绑定标题
        contentBuilder: () => {
          this.SetupContent(Test_Setup, 2)
        }
      })
        .width('50%')
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}