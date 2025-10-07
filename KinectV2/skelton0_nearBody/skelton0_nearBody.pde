// kinect V2用のライブラリ
import KinectPV2.*;

// RGBDカメラ用変数
KinectPV2 kinect;
ArrayList<KSkeleton> skeletonArray;

// サイズ変更関連の変数
PImage rsImg;
float rsScale = 0.5; // 画面表示のスケール変数
int w, h; // 変更する画像サイズ

void setup(){
  // スケールに合わせた画面サイズ
  w = (int)(1920 * rsScale);
  h = (int)(1080 * rsScale);
  surface.setResizable(true);
  surface.setSize(w, h);
  rsImg = createImage(w, h, RGB);
  
  // kinect関連の初期化
  kinect = new KinectPV2(this);
  kinect.enableColorImg(true);
  kinect.enableSkeletonColorMap(true);
  kinect.init();
  
}

void draw(){
  // カラー画像のリサイズ
  imageResize(kinect.getColorImage(), rsImg, rsScale);
  
  // カラー画像の表示
  image(rsImg, 0, 0);
  //image(kinect.getColorImage(), 0, 0);
  
  // スケルトン情報の取得
  skeletonArray =  kinect.getSkeletonColorMap();
  
  // 最近傍のスケルトンID取得
  int bodyNum = getNearestBodyNum(skeletonArray, 0.2);
  
  // 最近傍のスケルトンに対して処理する
  if(0 <= bodyNum){
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(bodyNum);
    
    // skeleton が使えるならば
    if(skeleton.isTracked()){
      // 関節の集合となる配列に変換
      KJoint[] joints = skeleton.getJoints();
      
      noFill();
      stroke(0, 255, 0);
      //for(int k = 0; k < joints.length; k++){
      for(int k = 0; k < 25; k++){
        float x = joints[k].getX() * rsScale;
        float y = joints[k].getY() * rsScale;
        ellipse(x, y, 20, 20);
      }

    }
  }
  
  fill(255, 0, 0);
  text(frameRate, 20, 40);
}


// 画像のリサイズ (簡易版の縮小用)
void imageResize(PImage src, PImage dst, float s){
  int i, j, u, v;
  float rate = 1 / s;
  int w_s = (int)(src.width * s), h_s = (int)(src.height * s);
  if(s == 1){
    dst = src.get();
    return;
  }
  dst.loadPixels();
  for(j = 0; j < h_s; j++){
    for(i = 0; i < w_s; i++){
      u = (int)(i * rate + s);
      v = (int)(j * rate + s) * src.width;
      dst.pixels[i + j * w_s] = src.pixels[u + v];
    }
  }
  dst.updatePixels();
}


// 最近傍のスケルトン取得【ここから】
ArrayList<KSkeleton> skeletonArray3D;
int getNearestBodyNum(ArrayList<KSkeleton> sa, float centerRatioX){
  skeletonArray3D =  kinect.getSkeleton3d();
  float nearDist = 1000, tmpDist;
  int nearestBodyNum = -1;
  
  // 中央範囲の境界を計算
  float centerX = 1920 / 2.0;
  float rangeX = 1920 * centerRatioX / 2.0;
  float leftX = centerX - rangeX;
  float rightX = centerX + rangeX;
  //println(skeletonArray.size(), skeletonArray3D.size());
  
  if (skeletonArray.size() != skeletonArray3D.size()) return nearestBodyNum;
  
  for(int i = 0; i < skeletonArray.size(); i++){
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    KSkeleton skeleton3D = (KSkeleton) skeletonArray3D.get(i);
    if(skeleton.isTracked() && skeleton3D.isTracked()){
      KJoint[] joints = skeleton.getJoints();
      
    // 画面中央の範囲に入っているかをチェック
      float k_x = joints[KinectPV2.JointType_SpineBase].getX();
      //println(k_x);
    
      if(leftX < k_x && k_x < rightX){
        
        tmpDist = _evalZdist(skeleton3D.getJoints());
        if(nearDist >= tmpDist){
          nearDist = tmpDist;
          nearestBodyNum = i;
        }
      }
    }
  }
  return nearestBodyNum;
}

// スケルトンの近さ評価
int skNum[] = {KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_FootLeft, KinectPV2.JointType_FootRight, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipLeft, KinectPV2.JointType_HandTipRight, KinectPV2.JointType_Head, KinectPV2.JointType_HipLeft, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_KneeRight, KinectPV2.JointType_Neck, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_SpineBase, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ThumbLeft, KinectPV2.JointType_ThumbRight, KinectPV2.JointType_WristLeft, KinectPV2.JointType_WristRight};
float _evalZdist(KJoint[] joints3D){
  int i, detectedNum = 0;
  float ave = 0;
  for(i = 0; i< skNum.length; i++){
    float x = -5000, y = -5000, z = -5000;
    x = joints3D[skNum[i]].getPosition().x;
    y = joints3D[skNum[i]].getPosition().y;
    z = joints3D[skNum[i]].getPosition().z;
    if(x != -5000 && y != -5000 && z != -5000){
      detectedNum++;
      ave += mag(x, y, z);
    }
  }
  if(detectedNum == 0) ave = 0;
  else ave /= detectedNum;
  return ave;
}
// 最近傍のスケルトン取得【ここまで】
