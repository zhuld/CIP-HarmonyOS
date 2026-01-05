import { common, ConfigurationConstant } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';

import { CameraComponent } from './Test/Camera';
import { SetupComponent } from './Test/Setup';
import { SoundComponent } from './Test/Sound';
import { VideoComponent } from './Test/Video';
import { Video2Component } from './Test/Video2';
import { HomeComponent } from './Test/Home';
import { pages, prefName, processID } from './Test/Config';
import { ConnectComponent } from './Connect'
import { PageModel } from '../models/Models';
import { TabButton } from '../components/TabButton';
import { Head } from '../components/Head';
import { CrestronClient, JoinType } from '../crestron/CrestronClient';
import { ProcessDialog } from './Dialog';

@Entry
@ComponentV2
struct Index {
  private tabScroller: Scroller = new Scroller();
  private contentScroller: Scroller = new Scroller();
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private connectTimer: number = 0;
  private isDialogOpened: boolean = false;
  private lastPage: number = 0;

  private dialogProcess: CustomDialogController = new CustomDialogController({
    builder: ProcessDialog({
      title: $r('app.string.processDialog'),
      autoClose:5000,
      onClose: () => {
        this.crestronClient.channelDArray[processID] = false;
        this.isDialogOpened = false
      }
    }),
    alignment: DialogAlignment.Center,
    autoCancel: false,
    width: '50%',
    height: '50%',
  });
  @Local currentPage: number = 0;
  @Local crestronClient: CrestronClient = new CrestronClient();
  @Local serverIP: string = '192.168.1.10';
  @Local serverPort: number = 41794;
  @Local cipId: number = 3;
  @Local showDebug: boolean = false;
  @Local isConnected: boolean = false;
  @Local isDarkMode: boolean = false;
  @Local messageT: string = '';
  @Local messageR: string = '';

  async aboutToAppear() {
    await this.loadPreferences();

    try {
      this.context.getApplicationContext()
        .setColorMode(this.isDarkMode ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK
          : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
    } catch (error) {
      console.error('Failed to set colorMode. Cause: %{public}s', JSON.stringify(error));
    }

    this.connectTimer = setInterval(() => {
      if (this.isConnected) {
        this.crestronClient.ping();
      } else {
        this.crestronClient.connect(this.serverIP, this.serverPort, this.cipId);
      }
    }, 10000)
    this.crestronClient.onConnectChanged = ((isConnected: boolean) => {
      this.isConnected = isConnected;
      if (this.isConnected) {
        this.contentScroller.scrollToIndex(this.lastPage);
        this.currentPage = this.lastPage
      } else {
        this.contentScroller.scrollToIndex(pages.pageList.length);
        this.lastPage = this.currentPage
        this.currentPage = pages.pageList.length
      }
    })

    this.crestronClient.onMsgReceived = ((joinType: JoinType, channel: number, value: number) => {
      if (joinType === JoinType.Digital) {
        if (this.showDebug) {
          this.messageR = value === 1 ? `${channel}:High` : `${channel}:Low`
        }
        if (channel === processID) {
          if (value === 1 && this.isDialogOpened) {
            this.dialogProcess.close()
            this.isDialogOpened = false
          } else {
            this.dialogProcess.open()
            this.isDialogOpened = true
          }
        }
      } else if (joinType === JoinType.Analog) {
        if (this.showDebug) {
          this.messageR = `${channel}:${value}`
        }
      }
    })

    this.crestronClient.onMsgSend = ((joinType: JoinType, channel: number, value: number) => {
      if (this.showDebug) {
        if (joinType === JoinType.Digital) {
          this.messageT = value === 1 ? `${channel}:Push` : `${channel}:Release`
        } else if (joinType === JoinType.Analog) {
          this.messageT = `${channel}:${value}`
        }
      }
    })

    this.crestronClient.connect(this.serverIP, this.serverPort, this.cipId);

    this.contentScroller.scrollToIndex(pages.pageList.length);
    this.currentPage = pages.pageList.length
  }

  private async loadPreferences() {
    try {
      const pref = await preferences.getPreferences(this.context, prefName);
      this.serverIP = await pref.get('ip', '192.168.1.10') as string;
      this.serverPort = await pref.get('port', 41794) as number;
      this.cipId = await pref.get('ipId', 3) as number;
      this.showDebug = await pref.get('debug', false) as boolean;
      this.isDarkMode = await pref.get('darkMode', false) as boolean;
    } catch (error) {
      console.error('加载设置失败:', error.message);
    }
  }

  async onPageShow(): Promise<void> {
    await this.loadPreferences()
    this.messageT = ''
    this.messageR = ''
  }

  aboutToDisappear(): void {
    this.crestronClient.close();
    clearInterval(this.connectTimer)
  }

  build() {
    Column() {
      Head({
        isConnected: this.isConnected,
        messageT: this.messageT,
        messageR: this.messageR,
        title: pages.title,
        fontSize: 18,
      })
        .width('100%')
        .layoutWeight(1)
      Row({ space: 20 }) {
        // [Start Side_tab_list]
        // 创建分类列表，用于显示页面选项，并通过Scroller实现滚动功能
        Stack() {
          List({ scroller: this.tabScroller }) {
            ForEach(pages.pageList, (item: PageModel, index?: number) => {
              TabButton({
                label: item.pageName,
                icon: item.pageIcon,
                checked: (this.currentPage === index ? true : false),
                isEnabled: this.isConnected,
                onTouchAction: (event: TouchEvent) => {
                  if (index !== undefined && event.type === TouchType.Down) {
                    this.currentPage = index;
                    this.contentScroller.scrollToIndex(index);
                  }
                }
              })
                .padding(10)
            },)
          }
          .height('100%')
          .width('100%')
          .scrollBar(BarState.Off)
          .fadingEdge(true)
        }
        .height('100%')
        .layoutWeight(1)

        //内容
        Stack() {
          List({ scroller: this.contentScroller, space: 100 }) {
            HomeComponent({ crestronClient: this.crestronClient })
            Video2Component({ crestronClient: this.crestronClient })
            VideoComponent({ crestronClient: this.crestronClient })
            SoundComponent({ crestronClient: this.crestronClient })
            CameraComponent({ crestronClient: this.crestronClient })
            SetupComponent({ crestronClient: this.crestronClient })
            ConnectComponent({
              serverIP: this.serverIP,
              serverPort: this.serverPort,
              ipId: this.cipId,
              isConnected: this.isConnected
            })
          }
          .enableScrollInteraction(false)
          .scrollBar(BarState.Off)
          .height('100%')
          .width('100%')
          .onScrollStart(() => {
            this.contentScroller.scrollToIndex(this.currentPage)
          })
        }
        .height('100%')
        .layoutWeight(7)
      }
      .width('100%')
      .layoutWeight(20)
    }
    .padding({
      top: 4,
      right: 16,
      left: 20,
      bottom: 16
    })
    .linearGradient({
      angle: 180,
      colors: [
        [$r('app.color.background_1'), 0.0],
        [$r('app.color.background_2'), 1],
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}