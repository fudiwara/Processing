// videoライブラリの読み込み(キャプチャに利用)
import processing.video.*;
// カメラ用の変数
Capture cam;
int w = 640, h = 480;

void setup(){
  // ウィンドウサイズと取り込みサイズを決めて初期化
  surface.setResizable(true);
  surface.setSize(w, h);
  
  cam = new Capture(this, w, h);
  
  // 上記が動かない場合
  //String[] cl = Capture.list();
  //cam = new Capture(this, cl[0]);
  
  // 取り込み開始
  cam.start();
  
  // text用のフォント設定
  fill(255, 0, 0);
  textSize(20);
}

void draw(){
  // カメラが取り込める状態(動いている場合)はメモリに
  if(cam.available()) cam.read();
  
  // 読み込んだ画像を表示
  image(cam, 0, 0);
  
  text(frameRate, 10, 30);
}
