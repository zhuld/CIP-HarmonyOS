import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../models/Models'
import { Category } from '../../components/Category';
import { testSetup } from './Config'
import { RoundButton } from '../../components/RoundButton';

@ComponentV2
export struct SetupComponent {
  @Param @Require crestronClient: CrestronClient

  @Builder
  SetupContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 120, y: 40 }
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
              RoundButton({
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
              })//.height(80)
            }
          }
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 40, left: 40 })
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: testSetup.title, // 动态绑定标题
        subTitle: testSetup.subTitle,
        icon: testSetup.icon,
        checkButton: testSetup.checkId ? true : false,
        checked: this.crestronClient.channelDArray[testSetup.checkId],
        contentBuilder: () => {
          this.SetupContent(testSetup.buttonList, 2)
        },
        onTouchAction: (event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.crestronClient?.push(testSetup.checkId)
          } else if (event.type === TouchType.Up) {
            this.crestronClient?.release(testSetup.checkId)
          }
        },
      })
        .width('50%')
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}