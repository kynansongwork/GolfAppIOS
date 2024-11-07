//
//  NetworkingTests.swift
//  GolfAppTests
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation
import XCTest
@testable import GolfApp

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkingManager?
    let mockURL = "https://www.google.com"
    let mockData = Data("{ \"name\": \"Test Testerson\" }".utf8)

    override func setUpWithError() throws {
        
        let mockResponse = HTTPURLResponse(url: URL(string: mockURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let mockURLSession = MockURLSession(data: mockData, response: mockResponse, error: nil)
        
        sut = NetworkingManager(url: URL(string: mockURL)!,
                                urlSession: mockURLSession as URLSessionProtocol)
    }
    
    func testGetDataSuccessfulResponse() async throws {
        //When
        let result: [String: String]? = try await sut?.getData(request: URLRequest(url: URL(string: mockURL)!))
        
        //Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?["name"], "Test Testerson")
    }

}
