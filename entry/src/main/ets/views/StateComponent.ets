import { CommonSkeleton } from '../constants/CommonSkeleton'
import { ViewStateConstant } from '../constants/ViewStateConstant'

/**
 *骨架
 */
@Component
export struct  StateComponent{
  @Prop viewState:string
  //页面内容区域组件
  @BuilderParam viewContent :()=>void

  //重试回调的方法
  retryCallback?:()=>void
  
  //是否骨架屏幕
  private showSkeleton:boolean=false
  



  build() {
    Stack(){
      //判断页面状态，如果不是成功
      // if (this.viewState!=ViewStateConstant.VIEW_STATE_SUCCESS){
      //   this.holdContent()
      // }else{
        this.viewContent()
      // }
    }
  }

  @Builder
  holdContent(){
    //判断显示是否显示骨架为true，页面的状态是加载中
    if (this.showSkeleton&&this.viewState==ViewStateConstant.VIEW_STATE_LOADING){
      //展示骨架
      CommonSkeleton()
    }else{
      Column(){
        Image(this.convertImage())
          .width($r('app.float.size_100'))
          .height($r('app.float.size_100'))
        Text(this.convertValue())
          .fontSize($r('app.float.size_text_15'))
          .fontColor($r("app.color.color_666"))
          .margin($r('app.float.size_10'))
        if (this.viewState!=ViewStateConstant.VIEW_STATE_LOADING) {
          //点击重新加载布局
          Button($r('app.string.press_retry'))
            .width($r('app.float.size_120'))
            .height($r('app.float.size_35'))
            .backgroundColor($r('app.color.color_red'))
            .fontColor($r('app.color.color_fff'))
            .onClick(()=>{
              this.retryCallback?.()
            })
        }
      }
    }
  }

  /**
   * 转换文字
   * @returns
   */

  convertValue(){
    switch (this.viewState){
      case ViewStateConstant.VIEW_STATE_LOADING:
        return $r('app.string.loading')
      case ViewStateConstant.VIEW_STATE_ERROR:
        return $r('app.string.load_error')
      case ViewStateConstant.VIEW_STATE_NETWORK_ERROR:
        return $r('app.string.net_error')
      case ViewStateConstant.VIEW_STATE_EMPTY:
        return $r('app.string.load_emtpy')
      default:
        return $r('app.string.load_success')
    }
  }
  /**
   * 转换图片
   * @returns
   */
  convertImage() {
    switch (this.viewState) {
      case ViewStateConstant.VIEW_STATE_LOADING:
        return $r('app.media.loading')
        break;
      case ViewStateConstant.VIEW_STATE_ERROR:
        return $r('app.media.common_empty_content')
        break;
      case ViewStateConstant.VIEW_STATE_NETWORK_ERROR:
        return $r('app.media.timeout')
        break;
      case ViewStateConstant.VIEW_STATE_EMPTY:
        return $r('app.media.common_empty_content')
        break;
      default:
        return $r('app.media.loading')
        break;
    }
  }
}

