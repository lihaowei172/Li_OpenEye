@Entry
@Component
export  struct HotPage {
  @State message: string = '热门';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HotPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}