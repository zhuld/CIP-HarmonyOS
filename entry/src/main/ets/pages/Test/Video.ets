import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../model/Models'
import { Category } from '../../view/Category';
import { NormalButton } from '../../view/NormalButton';
import { testVideoInput, testVideoOutput } from './Config'

@ComponentV2
export struct VideoComponent {
  @Param @Require crestronClient: CrestronClient

  @Builder
  InputContent(buttonList: ButtonModel[], columns: number) {
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
            checked: this.crestronClient.channelDArray[item.buttonId],
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

  @Builder
  OutputContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 25 }
    }) {
      ForEach(buttonList, (item: ButtonModel) => {
        GridCol({ span: 1 }) {
          NormalButton({
            label: item.buttonName,
            icon: item.buttonIcon,
            fontSize: 30,
            checked: this.crestronClient.channelDArray[item.buttonId],
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
        title: testVideoOutput.title, // 动态绑定标题
        icon: testVideoOutput.icon,
        contentBuilder: () => {
          this.OutputContent(testVideoOutput.buttonList, 1)
        } // 动态绑定内容
      })
        .layoutWeight(1)
      Category({
        title: testVideoInput.title, // 动态绑定标题
        icon: testVideoInput.icon,
        contentBuilder: () => {
          this.InputContent(testVideoInput.buttonList, 2)
        }
      })
        .layoutWeight(2)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}