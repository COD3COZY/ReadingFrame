//
//  LoginAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/21/24.
//

import Foundation
import Alamofire

/// 카카오&애플 로그인 API
class LoginAPI: BaseAPI {
    static let shared = LoginAPI()
    
    private override init() {
        super.init()
    }
    
    /// 카카오 로그인 API
    func loginKakao(request: KakaoLoginRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(LoginService.loginKakao(request), interceptor: MyRequestInterceptor()).responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode
                else {
                    return
                }
                guard let data = response.value
                else {
                    return
                }
                completion(self.judgeData(status: statusCode, data: data))
            case .failure(let err):
                completion(.networkFail(err))
            }
        }
    }
    
    /// 카카오 로그인 응답 분기 처리
    private func judgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CommonResponse<KakaoLoginResponse>.self, from: data)
        else {
            return .pathErr
        }
        
        switch status {
        // 로그인 성공
        case 200:
            print(decodedData.message)
            return .success(decodedData.data ?? decodedData.message)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr(decodedData.message)
        default:
            return .networkFail(decodedData.message)
        }
    }
}
