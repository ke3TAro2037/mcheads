String html = '''

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>再生モード</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #f5f5f5;
            height: 100vh;
            user-select: none;
            /* 文字選択を無効化 */
            -webkit-user-select: none;
            /* Safari用 */
            -ms-user-select: none;
            /* 旧IE用 */
        }

        .button-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-top: 15px;
            margin-bottom: 10px;
        }

        .button {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 80px;
            height: 80px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.2s ease, transform 0.2s ease;
            cursor: pointer;
        }

        .button:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transform: translateY(-2px);
        }

        .button svg {
            width: 30px;
            height: 30px;
            margin-bottom: 5px;
        }

        .button-label {
            font-size: 12px;
            color: #555;
        }

        .description {
            background-color: white;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 235px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: left;
            font-size: 14px;
            color: #333;
        }


        .svg-icon-green {
            width: 30px;
            height: 30px;
            margin: 10px;
            transition: filter 0.3s ease;
            cursor: pointer;
            filter: invert(70%) sepia(54%) saturate(551%) hue-rotate(110deg) brightness(93%) contrast(89%);
            opacity: 1;
        }

        .svg-icon-orange {
            width: 30px;
            height: 30px;
            margin: 10px;
            transition: filter 0.3s ease;
            cursor: pointer;
            filter: invert(58%) sepia(90%) saturate(726%) hue-rotate(359deg) brightness(98%) contrast(91%);
            opacity: 1;
        }

        img {
            pointer-events: none;
        }
    </style>


    <style>
        /* 動画プレイヤーの配置 */
        #player {
            position: relative;
            margin: 0 auto;
            width: 100%;
            aspect-ratio: 16 / 9;
        }

        /* 字幕のスタイル */
        #subtitle {
            position: absolute;
            top: 20%;
            /* 動画の中央に表示 */
            left: 50%;
            transform: translate(-50%, -50%);
            /* 中央揃え */
            width: 90%;

            /* 動画の幅に合わせる */
            text-align: center;
            color: white;
            font-size: 24px;
            /*background: rgba(0, 0, 0, 0.5);   半透明の背景 */
            padding: 10px;
            font-family: 'CustomFont', sans-serif;
            z-index: 10;
            word-wrap: break-word;
        }

        @font-face {
            font-family: 'CustomFont';
            src: url('path/to/your-font.ttf') format('truetype');
            /* フォントファイルのパス */
        }

        /* ボタンのスタイル */
        #controls {
            position: absolute;
            top: 80%;
            left: 50%;
            transform: translateX(-50%);
            z-index: 20;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        #controls button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        #controls button:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <div id="player"></div>
    <div id="subtitle"></div>

    <div class="button-grid">
        <div class="button" id="previousButton_flag">
            <img src="skip-start.svg" class="svg-icon-green">
            <div class="button-label" id="previousButton">前へ</div>
        </div>
        <div class="button" id="playButton_flag">
            <img src="pause.svg" class="svg-icon-green" id="svg-play">
            <div class="button-label" id="playButton">停止</div>
        </div>
        <div class="button" id="nextButton_flag">
            <img src="skip-end.svg" class="svg-icon-green">
            <div class="button-label" id="nextButton">次へ</div>
        </div>
        <div class="button" id="loopButton_flag">
            <img src="repeat.svg" class="svg-icon-green" id="svg-repeat">
            <div class="button-label" id="loopButton">リピート</div>
        </div>
        <div class="button" id="lyricButton_flag">
            <img src="lyric.svg" class="svg-icon-green" id="svg-lyric">
            <div class="button-label" id="lyricButton">歌詞の表示</div>
        </div>
        <div class="button" id="shuffleButton_flag">
            <img src="shuffle.svg" class="svg-icon-green" id="svg-shuffle">
            <div class="button-label" id="shuffleButton">シャッフル</div>
        </div>
        <div class="button" id="copyButton_flag">
            <img src="share.svg" class="svg-icon-orange">
            <div class="button-label" id="copyButton">共有</div>
        </div>
        <div class="button" id="playlistButton_flag">
            <img src="playlist.svg" class="svg-icon-orange">
            <div class="button-label" id="playlistButton">プレイリスト</div>
        </div>
        <div class="button" id="editButton_flag">
            <img src="edit.svg" class="svg-icon-orange">
            <div class="button-label" id="editButton">歌詞を編集</div>
        </div>
    </div>
    <div class="description">
        <strong>
            <font color="gray">概要欄</font>
        </strong>
        <br>
        <font color="gray">
            Showcase a couple of eye-catching screenshots or mockups of your UI Kit to capture attention and give users
            a
            glimpse of what they can expect.
        </font>
    </div>





    <script src="https://www.youtube.com/iframe_api"></script>
    <script>
            getPlaylist();
            console.log(playlist);


            setTimeout(() => {

                let isPlaying = true; // 再生中か停止中かを追跡
                let player;
                const subtitleDiv = document.getElementById('subtitle');
                const playButton_svg = document.getElementById("svg-play");
                const lyricButton_svg = document.getElementById("svg-lyric");
                const loopButton_svg = document.getElementById("svg-repeat");
                const shuffleButton_svg = document.getElementById("svg-shuffle");



                let subtitles = [];


                lyric_reload();

                let init_seconds;
                let next_init_seconds;
                let previous_init_seconds;
                let end_seconds;
                let NextVideoId;
                let CurrentVideoId;
                let PreviousVideoId;
                let loop = false;
                let shuffle = false;
                let lyric = true;
                let playlist = []; // グローバル変数を宣言
                let playing_i = 0;







                // YouTube Iframe API が準備できた時に呼ばれる
                function onYouTubeIframeAPIReady() {

                    setTimeout(() => {
                        console.log(CurrentVideoId)

                        player = new YT.Player('player', {
                            videoId: CurrentVideoId, // YouTube動画のIDを指定
                            playerVars: {
                                autoplay: 1,  // 自動再生は無効
                                controls: 1,  // コントロールバー非表示
                                modestbranding: 1, // ロゴ非表示
                                rel: 0,  // 関連動画非表示
                                start: init_seconds,
                            },
                            events: {
                                onReady: onPlayerReady,
                                onStateChange: onPlayerStateChange
                            }
                        });

                    }, 1000);
                }

                // プレイヤーが準備できたら呼ばれる
                function onPlayerReady(event) {
                    startSubtitleTimer();  // 字幕タイマーのスタート
                }

                // 動画再生中に字幕を表示するタイマー
                function startSubtitleTimer() {
                    setInterval(() => {
                        if (player && player.getCurrentTime) {
                            const currentTime = player.getCurrentTime();
                            if (lyric) {
                                updateSubtitle(currentTime);
                            }
                            updateSystem(currentTime);
                        }
                    }, 100); // 100msごとに更新
                }

                // 現在の再生時間に合わせて字幕を表示
                function updateSubtitle(currentTime) {
                    const subtitle = subtitles.find(sub => currentTime >= sub.start && currentTime <= sub.end);
                    if (subtitle) {
                        subtitleDiv.innerText = subtitle.text;
                    } else {
                        subtitleDiv.innerText = ''; // 表示する字幕がなければ消す
                    }
                }


                function updateSystem(currentTime) {
                    if (end_seconds <= currentTime) {
                        if (loop) {
                            //ループON
                            if (player && typeof player.seekTo === 'function') {
                                player.seekTo(init_seconds, true); // trueにして即座に移動
                            }

                        } else {
                            //ループOFF
                            if (NextVideoId) {
                                changeVideo(NextVideoId, next_init_seconds); // 入力された動画IDに変更
                            }
                        }
                    }
                }

                // 再生ボタンをクリックした時の処理
                document.getElementById('playButton_flag').addEventListener('click', function () {
                    if (player && typeof player.playVideo === 'function') {
                        player.playVideo();  // 動画を再生
                    }
                });




                // Previousボタンをクリックした時の処理
                document.getElementById('previousButton_flag').addEventListener('click', function () {


                    // init_secondsと現在の再生時間が、3秒以内のズレの場合は、前の動画にする。
                    if (player && player.getCurrentTime) {
                        const currentTime = player.getCurrentTime();
                        if (currentTime <= (init_seconds + 3)) {
                            //前の動画へ

                            if (PreviousVideoId) {
                                changeVideo(PreviousVideoId, previous_init_seconds); // 入力された動画IDに変更
                            }
                        } else {
                            // init_secondsへ
                            if (player && typeof player.seekTo === 'function') {
                                player.seekTo(init_seconds, true); // trueにして即座に移動
                            }
                        }
                    }

                });





                // 再生・停止ボタンの切り替え
                const playButton = document.getElementById('playButton');
                document.getElementById('playButton_flag').addEventListener('click', () => {
                    if (isPlaying) {
                        player.pauseVideo(); // 停止
                        playButton.textContent = '再生'; // ボタンテキストを更新
                        playButton_svg.src = "play.svg";
                    } else {
                        player.playVideo(); // 再生
                        playButton.textContent = '停止'; // ボタンテキストを更新
                        playButton_svg.src = 'pause.svg';
                    }
                    isPlaying = !isPlaying; // 状態を反転
                });

                // 動画を変更する関数
                function changeVideo(videoId, seconds) {

                    set_from_playlist();
                    getLyric();

                    player.loadVideoById({
                        videoId: videoId,
                        startSeconds: seconds // 60秒から再生
                    });

                    isPlaying = true; // 状態を再生中にリセット
                    playButton.textContent = '停止'; // ボタンを停止に設定
                    playButton_svg.src = 'pause.svg';

                }

                // ボタンのクリックイベントで動画IDを変更
                document.getElementById('nextButton_flag').addEventListener('click', function () {
                    if (NextVideoId) {
                        changeVideo(NextVideoId, next_init_seconds); // 入力された動画IDに変更
                    }
                });


                // ボタンのクリックイベントでループを切り替え
                document.getElementById('loopButton_flag').addEventListener('click', function () {
                    if (loop) {
                        //ONのとき、OFFに変える
                        loop = false;
                        loopButton_svg.src = 'repeat.svg';
                    } else {
                        //OFFのとき、ONに変える
                        loop = true;
                        loopButton_svg.src = 'repeat1.svg';
                    }
                });


                // ボタンのクリックイベントで動画のURLをコピー
                document.getElementById('copyButton_flag').addEventListener('click', function () {
                    navigator.clipboard.writeText('https://www.youtube.com/watch?v=' + CurrentVideoId);

                });

                // ボタンのクリックイベントで歌詞を切り替え
                document.getElementById('lyricButton_flag').addEventListener('click', function () {
                    if (lyric) {
                        //ONのとき、OFFに変える
                        lyric = false;
                        subtitleDiv.innerText = ''; // 表示する字幕がなければ消す
                        lyricButton_svg.style.opacity = "0.3";

                    } else {
                        //OFFのとき、ONに変える
                        lyric = true;
                        lyricButton_svg.style.opacity = "1";
                        if (player && player.getCurrentTime) {
                            const currentTime = player.getCurrentTime();
                            if (lyric) {
                                updateSubtitle(currentTime);
                            }
                        }
                    }
                });


                // ボタンのクリックイベントでシャッフルを切り替え
                document.getElementById('shuffleButton_flag').addEventListener('click', function () {

                    if (shuffle) {
                        //ONのとき、OFFに変える
                        shuffle = false;
                        shuffleButton_svg.style.opacity = "0.3";

                    } else {
                        //OFFのとき、ONに変える
                        shuffle = true;
                        shuffleButton_svg.style.opacity = "1";
                        playlist_reload();

                        //APIでNextVideoIdなどをシャッフルした状態のものをもらう。
                    }

                });

                // YouTube Iframe APIを読み込んだ後、プレイヤーを初期化
                function onPlayerStateChange(event) {
                    // プレイヤーの状態に応じた処理をここに追加できます（オプション）
                }


                async function getLyric() {
                    const requestOptions = {
                        method: "GET",
                        redirect: "follow"
                    };

                    try {
                        const response = await fetch("https://made-by-free.com/youtube_app/lyric.php", requestOptions);
                        const result = await response.json();
                        subtitles = result['lyric']; // グローバル変数に代入
                        console.log(result['lyric'])
                    } catch (error) {
                        console.error('エラー:', error);
                    }

                }


                async function getPlaylist() {

                    //GETパラメータからplaylist_idを取得
                    const url = new URL(window.location.href);
                    const playlist_id = url.searchParams.get("playlist_id");

                    const requestOptions = {
                        method: "GET",
                        redirect: "follow"
                    };

                    try {
                        const response = await fetch("http://ke3taro2037.m31.coreserver.jp/mcheads/playlist.php?mode=all&playlist_id=" + playlist_id, requestOptions);
                        const result = await response.json();
                        playlist = result['data']; // グローバル変数に代入
                    } catch (error) {
                        console.error('エラー:', error);
                    }

                    set_from_playlist();


                    console.log(playlist);
                }



                function arrayShuffle(array) {
                    for (let i = (array.length - 1); 0 < i; i--) {

                        // 0〜(i+1)の範囲で値を取得
                        let r = Math.floor(Math.random() * (i + 1));

                        // 要素の並び替えを実行
                        let tmp = array[i];
                        array[i] = array[r];
                        array[r] = tmp;
                    }
                    return array;
                }

                function playlist_reload() {
                    getPlaylist();
                    setTimeout(() => {
                        playlist_new = arrayShuffle(playlist);
                        return playlist_new;
                    }, 1000);
                }


                function lyric_reload() {
                    getLyric();
                }


                function set_from_playlist() {

                    getPlaylist();

                    playing_max = playlist.length;

                    if (playing_i >= playing_max) {
                        playing_i = 0;
                    } else {
                        playing_i = playing_i + 1;
                    }


                    getPlaylist();
                    setTimeout(() => {

                        if (playing_i == 0) {
                            //最初の動画のとき
                            playlist[playing_i];
                            init_seconds = playlist[playing_i]['start'];
                            next_init_seconds = playlist[playing_i + 1]['start'];
                            previous_init_seconds = playlist[playing_max]['start'];
                            end_seconds = playlist[playing_i]['end'];
                            NextVideoId = playlist[playing_i + 1]['youtube_video_id'];
                            CurrentVideoId = playlist[playing_i]['youtube_video_id'];
                            PreviousVideoId = playlist[playing_max]['youtube_video_id'];
                        } else if (playing_i == playing_max) {
                            //最後の動画のとき
                            playlist[playing_i];
                            init_seconds = playlist[playing_i]['start'];
                            next_init_seconds = playlist[0]['start'];
                            previous_init_seconds = playlist[playing_i - 1]['start'];
                            end_seconds = playlist[playing_i]['end'];
                            NextVideoId = playlist[0]['youtube_video_id'];
                            CurrentVideoId = playlist[playing_i]['youtube_video_id'];
                            PreviousVideoId = playlist[playing_i - 1]['youtube_video_id'];
                        } else {
                            playlist[playing_i];
                            init_seconds = playlist[playing_i]['start'];
                            next_init_seconds = playlist[playing_i + 1]['start'];
                            previous_init_seconds = playlist[playing_i - 1]['start'];
                            end_seconds = playlist[playing_i]['end'];
                            NextVideoId = playlist[playing_i + 1]['youtube_video_id'];
                            CurrentVideoId = playlist[playing_i]['youtube_video_id'];
                            PreviousVideoId = playlist[playing_i - 1]['youtube_video_id'];
                        }

                        console.log(CurrentVideoId);

                    }, 1000);



                }

            }, 1000);

        };

    </script>
</body>

</html>

''';