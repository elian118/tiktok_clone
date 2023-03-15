import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const onVideoCreated = functions.firestore
    .document("videos/{videoId}")
    .onCreate(async (snapshot, context) => {
        await snapshot.ref.update({"hello": "from functions"});
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

    4) root > functions > src > index.ts 이동해 코드를 편집 후 파이어베이스에 배포한다.

        파이어베이스 함수를 변경한 후에는
        터미널에서 아래 명령으로 파이어베이스에 코드를 배포해야 한다.

        firebase deploy --only functions
*/