import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../model/Models'
import { Category } from '../../view/Category';
import { NormalButton } from '../../view/NormalButton';
import { testSetup } from './Config'

@ComponentV2
export struct SetupComponent {
  @Param @Require crestronClient: CrestronClient

  @Builder
  SetupContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
    }) {
      ForEach(buttonList, (item: ButtonModel, index?: number) => {
        if (index !== undefined) {
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
                checked: this.crestronClient.channelDArray[item.buttonId],
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
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 20, left: 20 })
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row({ space: 30 }) {
      Category({
        title: testSetup.title, // 动态绑定标题
        subTitle: testSetup.subTitle,
        icon: testSetup.icon,
        contentBuilder: () => {
          this.SetupContent(testSetup.buttonList, 2)
        }
      })
        .width('60%')
    }

    .margin({ bottom: 10, right: 10, left: 2 })
  }
}