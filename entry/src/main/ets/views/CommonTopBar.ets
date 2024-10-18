import { router, window } from '@kit.ArkUI'

/**
 * 自定义顶部top
 */

@Component
export struct CommonTopBar{
  @Prop title:string
  private titleAlignment: TextAlign = TextAlign.Center
  @Prop alpha: number = 1
  @State statusBarHeight: number = 0
  private backButton: boolean = true
  private onBackClick?: () => void


  aboutToAppear() {
    this.setSystemStatusBar()
  }
  //系统状态栏
  setSystemStatusBar(){
    let context = getContext(this)
    window.getLastWindow(context,(error,data)=>{
      //1.设置系统状态栏
      let avoidArea = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      //设置高度，接近值
      avoidArea.topRect.height=90
      this.statusBarHeight=avoidArea.topRect.height
      let bottomHeight = avoidArea.topRect.height
      const systemBarProperties: window.SystemBarProperties = {
        //顶部状态栏颜色
        statusBarColor: "#d81e06",
        statusBarContentColor: "#ffffff",
        isStatusBarLightIcon: true
      }
      data.setWindowSystemBarProperties(systemBarProperties, (err, result) => {

      })
    })
  }

  build() {
    Column(){
      Blank()
        .backgroundColor($r('app.color.color_red'))
        .opacity(1)
      Stack({alignContent:Alignment.Start}){
        Stack()
          .height($r('app.float.size_50'))
          .width("100%")
          .opacity(1)
          .backgroundColor($r("app.color.color_red"))
        Flex({direction:FlexDirection.Row,alignItems:ItemAlign.Center}){
          Text(this.title)
            .flexGrow(1)
            .textAlign(this.titleAlignment)
            .fontColor($r('app.color.color_fff'))
            .fontSize($r('app.float.size_text_16'))
            .align(Alignment.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .height($r('app.float.size_50'))
        .margin({ left: $r('app.float.size_50'), right: $r('app.float.size_50') })
        .alignSelf(ItemAlign.Center)
        
        if (this.backButton){
          Stack(){
            Image($r('app.media.ic_action_back'))
              .height($r('app.float.size_16'))
              .align(Alignment.Center)
              .height($r('app.float.size_16'))
              .onClick(()=>{
                this.onBackClick?.()
                router.back()
              })
          }.height($r('app.float.size_50'))
          .width($r('app.float.size_50'))
        }
      }
      .height($r('app.float.size_50'))
      .width('100%')
    }
  }
}
