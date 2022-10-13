Processing
---
#### [画像ファイル](https://github.com/fudiwara/processing/tree/master/Image)
適当な画像が手元に無い場合は利用してください。

#### 入門講座(プログラミング)
各プログラムの概要については配付資料を参考にしてください。  
* 第一回：[Introduction_01](https://github.com/fudiwara/processing/tree/master/Introduction_01)  
とりあえず動かしてみる。

* 第二回：[Introduction_02](https://github.com/fudiwara/processing/tree/master/Introduction_02)  
画像を開いて表示してみる。

* 第三回：[Introduction_03](https://github.com/fudiwara/processing/tree/master/Introduction_03)  
画像処理っぽいことをしてみる。

* 第四回：[Introduction_04](https://github.com/fudiwara/processing/tree/master/Introduction_04)  
ライブラリを使ってみる。

* 第五回：[Introduction_05](https://github.com/fudiwara/processing/tree/master/Introduction_05)  
顔検出を使ってみる。

* 第六回：[Introduction_06](https://github.com/fudiwara/processing/tree/master/Introduction_06)  
カメラを使ってみる。

* 第七回：[Introduction_07](https://github.com/fudiwara/processing/tree/master/Introduction_07)  
カメラ入力の応用例 1。

* 第七回(の発展的内容1)：[Introduction_07_2](https://github.com/fudiwara/processing/tree/master/Introduction_07_2)  
カメラ入力の応用例 2。

* 第七回(の発展的内容2)：[Introduction_07_3](https://github.com/fudiwara/processing/tree/master/Introduction_07_3)  
カメラ＋OpenCV 1。

* 第七回(の発展的内容2)：[Introduction_07_4](https://github.com/fudiwara/processing/tree/master/Introduction_07_4)  
カメラ＋OpenCV 2。

* 第八回：[Introduction_08](https://github.com/fudiwara/processing/tree/master/Introduction_08)  
Kinectのプログラム例。

* 第九回：[Introduction_09](https://github.com/fudiwara/processing/tree/master/Introduction_09)  
画面遷移の考え方。

#### Processingのバージョンについて
Video関連の扱いが楽なため、バージョンは4系の利用を前提とします。

#### Macでカメラを使う場合の注意点
※ 以下はバージョン3系の頃のtipsですが、4系でも同様かもしれません

macOS Catalina 10.15 (以降も?) でUSB接続のカメラを使う場合公式のVideoライブラリではおそらくエラーとなる。

先人の某ブログ

https://note.com/mement_mori1202/n/n4e888e7ef8b9

の手順でターミナル経由で実行する必要があるため注意すること。processing-javaを使うという点では、サウンド処理も同様になる(と思う)。

※ 10.14以前は(多分)問題ない

Videoライブラリの入手先については以下の最新版がよい(かもしれない)。

https://github.com/processing/processing-video/releases