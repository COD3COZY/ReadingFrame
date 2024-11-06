//
//  Bookmark.swift
//  ReadingFrame
//
//  Created by 이윤지 on 5/8/24.
//

import Foundation

/// 등록된 책(읽고 있는 책, 다 읽은 책)의 책갈피 모델
struct Bookmark: Identifiable, Codable {
    /// 책갈피 id
    let id: String
    
    /// 날짜
    var date: Date
    
    /// 마지막으로 읽은 페이지
    var markPage: Int
    
    /// 읽은 퍼센트
    var markPercent: Int
    
    // TODO: 위치는 필수 아니어서 옵셔널로 바꿔야 함!
    /// 책갈피한 위치
    var location: String
}
