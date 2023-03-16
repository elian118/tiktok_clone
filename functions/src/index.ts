import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(); // 관리자 권한으로 앱 초기화

// 동영상이 새로 생성될 때마다 아래 함수 실행 -> 이벤트 리스너
export const onVideoCreated = functions.firestore
    .document("videos/{videoId}")
    .onCreate(async (snapshot, context) => {
        const spawn = require('child-process-promise').spawn;
        const video = snapshot.data();
        await spawn("ffmpeg", [
            "-i",
            video.fileUrl, // 동영상 다운로드
            "-ss",
            "00:00:01.000", // 동영상 1초로 이동
            "-vframes",
            "1", // 첫 번째 프레임 가져오기
            "-vf", // 영상 필터 설정 -> 화질 낮추기
            "scale=150:-1", // 너비 150, 높이는 영상 비율에 맞춰 설정
            `/tmp/${snapshot.id}.jpg`, // 업로드 동안 잠시 구글 클라우드 서버에 생성되는 tmp 임시 폴더에서 가져온 프레임 이미지를 썸네일로 저장
        ]);
        const storage = admin.storage(); // 관리자 권한으로 저장소 접근 -> 임시 동영상이 위치한 곳으로(경로 동일해야 함)
        const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
            destination: `thumbnails/${snapshot.id}.jpg`, // 파이어베이스에 저장할 경로(버킷) 및 파일명 지정
        });
        // 파일 url 정보를 얻기 위해 공개상태로 변경
        await file.makePublic();
        await snapshot.ref.update({"thumbnailUrl": file.publicUrl()});

        // 동뎡상 정보 복사본 저장
        //  -> NoSql 방식은 서버 부하를 막고자 이러한 복사본을
        //      데이터베이스 내에 여럿 만들어두고 하나의 아이디로 접근 가능하도록 코드를 짠다.
        const db = admin.firestore();
        // 데이터베이스에 복사본 저장을 위한 새로운 컬랜션 생성
        await db.collection("users")
            .doc(video.creatorUid)
            .collection("videos")
            .doc(snapshot.id)
            .set({
                thumbnailUrl: file.publicUrl(),
                videoId: snapshot.id,
            });
    });

/*
    파이어베이스 함수를 사용하려면
    1) 터미널에서 아래 명령으로 플러터 패키지를 설치한다.

        flutter pub add cloud_functions

        물론, 플러터파이어 설정도 다시 해준다.

        flutterfire configure

    2) 노드가 설치돼 있다는 가정 하에 터미널에서 아래 명령으로 파이어베이스 함수를 초기화한다.

        firebase init functions
        ? Please select an option: Use an existing project
        ? Select a default Firebase project for this directory: tiktok-clone-elian (tiktok-clone-elian)
        ? What language would you like to use to write Cloud Functions? TypeScript
        ? Do you want to use ESLint to catch probable bugs and enforce style? No
        ? Do you want to install dependencies with npm now? Yes

        성공적으로 수행됐다면, 프로젝트 안에 functions 폴더가 새로 생성돼 있고,
        그 안에 타입스크립트 프로젝트가 만들어진 것을 확인할 수 있다.

    4) root > functions > src > index.ts 이동해 코드 편집 후 파이어베이스에 배포한다.

        파이어베이스 함수를 변경한 후에는
        터미널에서 아래 명령으로 파이어베이스에 코드를 배포해야 한다.

        firebase deploy --only functions
*/
/*
    ffmpeg 는 구글 파이어베이스에 설치돼 있는 시스템 패키지다.
    파이어베이스 함수로도 이러한 시스템 패키지 코드를 호출해 사용할 수 있는데,

    ffmpeg 의 경우, 클라우드 서버에 저장된 동영상을 다루는 코드를 지원한다.
    다만, ffmpeg 만으로는 오로지 터미널에서만 명령을 내릴 수 있는데,
    이걸 파이어베이스 함수에서 사용할 수 있도록ㄷ 지원하는 또 다른 노드패키지
    child-promise-process 를 설치해 사용할 수 있다.

    이 패키지는 파이어베이스 시스템 패키지가 아니므로, functions 폴더 안에 의존성으로 추가해줘야 한다.
*/