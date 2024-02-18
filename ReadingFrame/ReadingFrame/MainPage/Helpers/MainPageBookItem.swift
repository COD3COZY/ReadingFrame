//
//  BookView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책, 다 읽은 책 리스트에 들어가는 개별 뷰
struct MainPageBookItem: View {
    var registeredBook: RegisteredBook
    @State var readingStatus: ReadingStatus = .reading
    @State var isRegisterSheetAppear: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                // MARK: 책 표지
                NavigationLink {
                    // 읽고 싶은 책이라면
                    if (registeredBook.book.readingStatus == .wantToRead) {
                        // TODO: 책 정보 화면으로 이동
                        
                    }
                    // 다 읽은 책 이라면
                    else if (registeredBook.book.readingStatus == .finishRead) {
                        // TODO: 독서 노트 화면으로 이동
                    }
                } label: {
                    // 책 표지 클릭 시, 각 화면으로 이동
                    LoadableBookImage(bookCover: RegisteredBook())
                        .frame(width: 173)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                // MARK: 책 이름
                Text(registeredBook.book.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black0)
                    .lineLimit(2)
                    .padding(.top, 12)
                
                // 저자 글자 개수에 따른 뷰 처리
                // 저자가 2줄 이상인 경우 bottom 정렬, 저자가 1줄인 경우 center 정렬
                HStack(alignment: registeredBook.book.author.count >= 14 ? .bottom : .center) {
                    // MARK: 저자
                    Text(registeredBook.book.author)
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundStyle(.greyText)
                    
                    Spacer()
                    
                    // MARK: 더보기 버튼
                    Menu {
                        // 읽고 싶은 책이라면
                        if (registeredBook.book.readingStatus == .wantToRead) {
                            // MARK: 읽는 중 버튼
                            Button {
                                // 버튼 누르면 sheet present되도록
                                isRegisterSheetAppear.toggle()
                                readingStatus = .reading
                            } label: {
                                Label("읽는 중", systemImage: "book")
                            }
                            // MARK: 다 읽음 버튼
                            Button {
                                isRegisterSheetAppear.toggle()
                                readingStatus = .finishRead
                            } label: {
                                Label("다 읽음", systemImage: "book.closed")
                            }
                        }
                        // 다 읽은 책 이라면
                        else if (registeredBook.book.readingStatus == .finishRead){
                            // MARK: 정보 버튼
                            Button {
                            } label: {
                                Label("정보", systemImage: "info.circle")
                            }
                            // MARK: 소장 버튼
                            Button {
                            } label: {
                                Label("소장", systemImage: "square.and.arrow.down")
                            }
                            // MARK: 리뷰 남기기 버튼
                            Button {
                            } label: {
                                Label("리뷰 남기기", systemImage: "ellipsis.bubble")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundStyle(.black0)
                    }
                    // sheet modal 보여주기 위한 코드
                    .sheet(isPresented: $isRegisterSheetAppear) {
                        // Sheet 뷰
                        RegisterBook(book: registeredBook.book, 
                                     readingStatus: $readingStatus,
                                     isSheetAppear: $isRegisterSheetAppear)
                    }
                }
                .frame(height: registeredBook.book.author.count >= 14 ? 32 : 16)
                .padding(.top, 5)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 173)
        .padding(.trailing, 12)
    }
}

#Preview {
    MainPageBookItem(registeredBook: RegisteredBook())
}
