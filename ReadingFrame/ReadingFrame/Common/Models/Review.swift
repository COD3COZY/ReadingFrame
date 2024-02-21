//
//  Review.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/18/24.
//

import Foundation
import Observation

// MARK: 개인용 책 등록용 3종류 리뷰
/// 사용자가 개별 책에 등록하는 3종 리뷰
struct Review {
    var selectReviews: [selectReviewCode]
    
    var keyword: String?
    
    var comment: String?
}

// MARK: 한줄평 관련 정보
/// 한줄평 조회시 사용될 한줄평 관련 정보
@Observable
class Comment: Identifiable {
    // MARK: Property
    let id = UUID()
    
    /// 한줄평 텍스트
    var commentText: String
    
    /// 한줄평 남긴 사람
    var nickname: String
    
    /// 한줄평 남긴 날짜
    var commentDate: Date
    
    /// 내가 반응남긴 경우에 어떤 반응인지
    var myReaction: commentReaction?
    
    // 한줄평에 달린 반응 개수
    private var heartCount: Int
    private var goodCount: Int
    private var wowCount: Int
    private var sadCount: Int
    private var angryCount: Int
    
    // MARK: Initializer
    init(commentText: String = "저는 이 책을 읽기 위해 태어났습니다",
         nickname: String = "사용자",
         commentDate: Date = Date(),
         myReaction: commentReaction? = nil,
         heartCount: Int = 0,
         goodCount: Int = 0,
         wowCount: Int = 0,
         sadCount: Int = 0,
         angryCount: Int = 0) {
        self.commentText = commentText
        self.nickname = nickname
        self.commentDate = commentDate
        self.myReaction = myReaction
        self.heartCount = heartCount
        self.goodCount = goodCount
        self.wowCount = wowCount
        self.sadCount = sadCount
        self.angryCount = angryCount
    }
    
    // MARK: Function
    /// UI 만들 때 조작용
    func setReactions(heart: Int, good: Int, wow: Int, sad: Int, angry: Int) {
        self.heartCount = heart
        self.goodCount = good
        self.wowCount = wow
        self.sadCount = sad
        self.angryCount = angry
    }
    
    /// 반응 추가
    func addReaction(reaction: commentReaction) {
        switch reaction {
        case .heart:
            heartCount += 1
        case .good:
            goodCount += 1
        case .wow:
            wowCount += 1
        case .sad:
            sadCount += 1
        case .angry:
            angryCount += 1
        }
    }
    
    /// 반응 제거
    func removeReaction(reaction: commentReaction) {
        switch reaction {
        case .heart:
            heartCount -= 1
        case .good:
            goodCount -= 1
        case .wow:
            wowCount -= 1
        case .sad:
            sadCount -= 1
        case .angry:
            angryCount -= 1
        }
    }
}


// MARK: - 관련 열거형
/// 한줄평 반응
enum commentReaction: Int {
    /// ❤️
    case heart
    /// 👍🏻
    case good
    /// 😲
    case wow
    /// 😢
    case sad
    /// 😤
    case angry
}

/// 선택리뷰 열거형. raw value는 정수입니다.
enum selectReviewCode: Int {
    // MARK: 내용 및 구성
    /// 창의적이에요
    case creative
    
    /// 전개가 시원해요
    case fastPaced
    
    /// 현실적이에요
    case realistic
    
    /// 사회적 주제를 다뤄요
    case socialTheme
    
    /// 철학적이에요
    case philosophical
    
    /// 역사적인 내용을 다뤄요
    case historical
    
    /// 환경문제를 다뤄요
    case environmentalIssues
    
    /// 새로운 관점을 제공해요
    case newPerspective
    
    /// 전문적이에요
    case specialized
    
    /// 구성이 탄탄해요
    case wellStructured
    
    /// 난해해요
    case convoluted
    
    // MARK: 감상
    /// 감동적이에요
    case touching
    
    /// 여운이 남아요
    case leaveLingering
    
    /// 위로가 되었어요
    case comforting
    
    /// 슬퍼요
    case sad
    
    /// 어려워요
    case difficult
    
    /// 쉽게 읽혀요
    case easyToRead
    
    /// 재미있어요
    case entertaining
    
    /// 통찰력이 있어요
    case insightful
    
    /// 유익해요
    case informative
    
    /// 몰입감 있어요
    case immersive
    
    /// 화가 나요
    case angering
    
    /// 강렬해요
    case intense
    
    // MARK: 기타
    /// 믿고보는 작가에요
    case trustworthyAuthor
    
    /// 숨은 명작이에요
    case hiddenGem
    
    /// 호불호가 갈릴 것 같아요
    case polarising
    
    /// 소장하고 싶어요
    case wantToOwn
    
    /// 추천하고 싶어요
    case recommend
    
    /// 여러 번 읽었어요
    case readMultiple
    
    /// 선물하기 좋아요
    case goodForGift
    
    /// 삽화/표지가 예뻐요
    case looksNice
    
    /// 후속편 원해요 (기타)
    case wantSequel

}
