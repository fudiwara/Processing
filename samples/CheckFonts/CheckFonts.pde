String[] fontList;
int fontIndex = 0;
PFont currentFont;

void setup() {
  size(800, 200);
  fontList = PFont.list();
  println("使用可能なフォント一覧:");
  for (int i = 0; i < fontList.length; i++) {
    println(i + ": " + fontList[i]);
  }
  updateFont();
}

void draw() {
  background(255);
  fill(0);
  textFont(currentFont);
  textSize(32);

  String testText = "半角: 0123456789  全角: ０１２３４５６７８９";
  text(fontIndex + "  フォント: " + fontList[fontIndex], 10, 50);
  text(testText, 10, 100);
}

void keyPressed() {
  if (keyCode == UP) {
    fontIndex = (fontIndex + 1) % fontList.length;
    updateFont();
  } else if (keyCode == DOWN) {
    fontIndex = (fontIndex - 1 + fontList.length) % fontList.length;
    updateFont();
  }
}

void updateFont() {
  currentFont = createFont(fontList[fontIndex], 32);
}
