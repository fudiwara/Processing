// kinect V2用のライブラリ
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

PImage rgbImg, d2cImg, clearImg, dImg;

float sysRatio = 2, sysScl; // スケール変数
int mW, mH;

void settings(){
  sysScl = 1.0 / sysRatio;
  mW = (int)(1920 * sysScl);
  mH = (int)(1080 * sysScl);
  size(mW, mH);
}

void setup(){
  int i, j;
  // kinect関連の初期化
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableDepthImg(true);
  kinect.enableDepthMaskImg(true);
  kinect.enablePointCloud(true);
  kinect.init();
  
  d2cImg = createImage(mW, mH, PImage.RGB); // RGB画像の座標における距離値
  
  // フレームクリア用の画像を用意しておく
  clearImg = createImage(mW, mH, PImage.RGB);
  clearImg.loadPixels();
  for(j = 0; j < mH; j++){
    for(i = 0; i < mW; i++){
      clearImg.pixels[i + j * mW] = color(0);
    }
  }
  clearImg.updatePixels();
  
  textSize(20);
}

void draw(){
  background(0);
  int i, j;
  float x, y;
  int u, v;
  color c, blk = color(0);
  int count = 0;
  
  float [] mapDCT = kinect.getMapDepthToColor(); // 距離-RGBの変換テーブル
  dImg = kinect.getBodyTrackImage(); // マスク画像(2値)
  
  rgbImg = kinect.getColorImage();
  
  // 距離値をRGBの座標にマッピング
  //d2cImg = clearImg.get();
  d2cImg.loadPixels();
  for(i = 0; i < KinectPV2.WIDTHDepth; i++){
    for(j = 0; j < KinectPV2.HEIGHTDepth; j++){
      // 変換テーブルから距離画像における座標がRGBのどこか(x, y)を取得する
      x = mapDCT[count * 2 + 0];
      y = mapDCT[count * 2 + 1];
      
      // (念のため)すみを省いて処理をする
      if(20 < x && x < 1900 && 20 < y && y < 1060){
        c = dImg.pixels[i* KinectPV2.HEIGHTDepth + j]; // 距離値のコピー
        if(c == blk){
          u = (int)(x * sysScl); // RGB座標の修正
          v = (int)(y * sysScl);
          // ボディ領域のみ描画する
          d2cImg.pixels[u + v * mW] = rgbImg.pixels[(int)x + (int)y * 1920]; 
        }
      }

      count++;
    }
  }
  d2cImg.updatePixels();
  
  image(d2cImg, 0, 0);
  d2cImg = clearImg.get();

  fill(255, 0, 0);
  //text(skeletonArray.size() + ", " + frameRate , 50, 50);
  text(frameRate , 50, 50);
}
