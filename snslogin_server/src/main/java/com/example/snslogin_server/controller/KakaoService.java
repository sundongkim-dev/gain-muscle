package com.example.snslogin_server.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.springframework.stereotype.Service;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.auth.UserRecord.CreateRequest;
import com.google.firebase.auth.UserRecord.UpdateRequest;


@Service
public class KakaoService {
    
    // getAccessToken과 getUserInfo 호출
    /*public Map<String, Object> execKakaoLogin(String authorize_code)
    {
        System.out.println("123123");
        Map<String, Object> result = new HashMap<String, Object>();
        // 엑세스 토큰 받기
        String accessToken = getKakaoAccessToken(authorize_code);
        result.put("accessToken", accessToken);

        // 사용자 정보 읽어오기
        Map<String,Object> userInfo = getKakaoUserInfo(accessToken);
        result.put("userInfo", userInfo);

        System.out.println(userInfo.toString());
        return result;
    }*/
    public Map<String, Object> execKaKaoLogin(String authorize_code)
    {
        Map<String, Object> result = new HashMap<String, Object>();
        String accessToken = getAccessToken(authorize_code);
        result.put("accessToken", accessToken);
        Map<String,Object> userInfo = getUserInfo(accessToken);
        result.put("userInfo", userInfo);
        System.out.println(userInfo.toString());
        return result;
    }

    public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=c2d358c9b44921bce63cdd0bdc042652");  //본인이 발급받은 key
            // 설정 redirect_uri 는 카카오에 등록된 경로를 작성하면 된다.
            sb.append("&redirect_uri=http://172.30.1.41:8080/kakao/sign_in"); // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            // Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonElement element = JsonParser.parseString(result);
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return access_Token;
    }
    public Map<String, Object> getUserInfo (String access_Token) {
        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        Map<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            int responseCode = conn.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            JsonElement element = JsonParser.parseString(result);
            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("profile_image", profile_image);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return userInfo;
    }

    /*
    public String getKakaoAccessToken (String authorize_code)
    {
        String access_Token = "";
        //String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            // POST 요청 - 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=c2d358c9b44921bce63cdd0bdc042652");  //본인이 발급받은 key
            sb.append("&redirect_uri=http://172.30.1.41:8080/kakao/sign_in"); // 본인이 설정해 놓은 경로

            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            if (responseCode == 200)
                System.out.println("성공!");

            // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }

            // Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonElement element = JsonParser.parseString(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            //refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return access_Token;
    }
    */

    /*
    public Map<String, Object> getKakaoUserInfo (String access_Token)
    {
        //  요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        Map<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // 요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            if(responseCode == 200)
                System.out.println("성공~~");

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }

            JsonElement element = JsonParser.parseString(result);
            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            String id = element.getAsJsonObject().get("id").getAsString();

            userInfo.put("id", id);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return userInfo;
    }
    */

    /*
    public String kakaoLogout(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            if(responseCode == 200)
                System.out.println("성공~!@!@");
            // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            br.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
    }

    // 기본 적으로 유효기간은 1시간 이며 유저 정보를 이용해서 생성할 수 있는 방법이 어려개 있음. ( 공식문서 참고 )
    public String createFirebaseCustomToken(Map<String,Object> userInfo) throws Exception
    {
        UserRecord userRecord;
        String uid = userInfo.get("id").toString();
        String email = userInfo.get("email").toString();
        String displayName = userInfo.get("nickname").toString();

        // 1. 사용자 정보로 파이어 베이스 유저정보 update, 사용자 정보가 있다면 userRecord에 유저 정보가 담긴다.
        try {
            UpdateRequest request = new UpdateRequest(uid);
            request.setEmail(email);
            request.setDisplayName(displayName);
            userRecord = FirebaseAuth.getInstance().updateUser(request);

            // 1-2. 사용자 정보가 없다면 > catch 구분에서 createUser로 사용자를 생성한다.
        } catch (FirebaseAuthException e) {

            CreateRequest createRequest = new CreateRequest();
            createRequest.setUid(uid);
            createRequest.setEmail(email);
            createRequest.setEmailVerified(false);
            createRequest.setDisplayName(displayName);

            userRecord = FirebaseAuth.getInstance().createUser(createRequest);
        }

        // 2. 전달받은 user 정보로 CustomToken을 발행한다.
        return FirebaseAuth.getInstance().createCustomToken(userRecord.getUid());
    }
    */
}