void setup() {
  String[] fontList = PFont.list();
  println("使用可能なフォント一覧:");
  for (int i = 0; i < fontList.length; i++) {
    println(fontList[i]);
  }
}
