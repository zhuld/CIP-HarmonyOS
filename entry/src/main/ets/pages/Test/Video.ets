import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../model/Models'
import { Category, NormalButton } from '../../view/Views'
import { Test_Video_Input, Test_Video_Output } from './Config'

@Component
export struct VideoComponent {
  @ObjectLink crestronClient: CrestronClient
  @Consume channelDArray: boolean[] = []
  @Consume channelAArray: number[] = []

  @Builder
  VideoContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
    }) {
      ForEach(buttonList, (item: ButtonModel) => {
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
          })
            .height(80)
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 20, left: 20 })
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row({ space: 30 }) {
      Category({
        title: '输出设备', // 动态绑定标题
        contentBuilder: () => {
          this.VideoContent(Test_Video_Output, 1)
        } // 动态绑定内容
      })
        .layoutWeight(1)
      Category({
        title: '输入信号', // 动态绑定标题
        contentBuilder: () => {
          this.VideoContent(Test_Video_Input, 2)
        }
      })
        .layoutWeight(2)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}