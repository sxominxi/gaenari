package com.gaenari.backend.global.format.code;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Getter
@RequiredArgsConstructor // final로 선언된 필드 생성자
public enum ResponseCode {

    // 회원(Member)
    MEMBER_SIGNUP_SUCCESS(HttpStatus.CREATED, "회원가입이 정상적으로 완료되었습니다."),
    NICKNAME_CHECK_SUCCESS(HttpStatus.OK, "닉네임 검사가 성공적으로 이루어졌습니다."),
    LOGIN_SUCCESS(HttpStatus.OK, "로그인이 성공적으로 이루어졌습니다."),
    LOGOUT_SUCCESS(HttpStatus.OK, "로그아웃이 성공적으로 이루어졌습니다."),
    PASSWORD_RESET_SUCCESS(HttpStatus.OK, "비밀번호 재설정이 성공적으로 이루어졌습니다."),
    PASSWORD_UPDATE_SUCCESS(HttpStatus.OK, "비밀번호 업데이트가 성공적으로 이루어졌습니다."),
    MEMBER_NICKNAME_UPDATE_SUCCESS(HttpStatus.OK, "회원 닉네임이 성공적으로 업데이트되었습니다."),
    MEMBER_PWD_UPDATE_SUCCESS(HttpStatus.OK, "회원 비밀번호가 성공적으로 업데이트되었습니다."),
    MEMBER_INFO_UPDATE_SUCCESS(HttpStatus.OK, "회원 정보가 성공적으로 업데이트되었습니다."),
    MATES_SUCCESS(HttpStatus.OK, "친구 목록을 성공적으로 불러왔습니다."),
    MATE_SENT_SUCCESS(HttpStatus.OK, "친구신청 발신 리스트를 성공적으로 불러왔습니다."),
    MATE_RECEIVED_SUCCESS(HttpStatus.OK, "친구신청 수신 리스트를 성공적으로 불러왔습니다."),
    APPLY_MATE_SUCCESS(HttpStatus.OK, "친구신청이 성공적으로 이루어졌습니다."),
    ACCEPT_MATE_SUCCESS(HttpStatus.OK, "친구수락이 성공적으로 이루어졌습니다."),
    REJECT_MATE_SUCCESS(HttpStatus.OK, "친구거부가 성공적으로 이루어졌습니다."),
    REMOVE_MATE_SUCCESS(HttpStatus.OK, "친구삭제가 성공적으로 이루어졌습니다."),
    SEARCH_MEMBER_SUCCESS(HttpStatus.OK, "멤버 검색이 성공적으로 이루어졌습니다."),
    COIN_FETCH_SUCCESS(HttpStatus.OK, "보유코인개수를 성공적으로 불러왔습니다."),
    ACCOUNT_SECESSION_SUCCESS(HttpStatus.OK, "계정 탈퇴가 성공적으로 이루어졌습니다."),
    NOTIFICATION_SETTING_UPDATED(HttpStatus.OK, "알림 설정이 성공적으로 업데이트되었습니다.");

    private final HttpStatus status;
    private final String message;
}
