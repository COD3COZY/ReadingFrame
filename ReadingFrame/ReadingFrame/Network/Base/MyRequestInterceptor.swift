//
//  MyRequestInterceptor.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/21/24.
//

import Foundation
import Alamofire

final class MyRequestInterceptor: RequestInterceptor {
    
    // 네트워크 호출 시, api 전처리를 한 뒤 서버로 보냄
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(APIConstants.baseURL) == true,
              let xAuthToken = KeyChain.shared.getToken() else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue(xAuthToken, forHTTPHeaderField: "xAuthToken")
        completion(.success(urlRequest))
    }
    
    // 응답에 실패했을 경우, 에러를 리턴(401의 경우만)
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
    }
}
