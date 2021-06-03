//
//  BitGalleryTests.swift
//  BitGalleryTests
//
//  Created by Khagesh Patel on 2/6/21.
//

import XCTest
@testable import BitGallery

class BitGalleryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test case to test BGRepository model class. here i have added few parameters but we can add more parameter in json string to test more edge cases

    func testBGRepositoryModel() throws {
        
        let jsonString = """
            {
                "pagelen": 10,
                "values": [{
                        "scm": "git",
                        "website": "http://rubyonrails.org/",
                        "has_wiki": false,
                        "uuid": "{c34751f8-0c4b-4981-bf96-84de39f91cd9}",
                    }],
                "next": "https://api.bitbucket.org/2.0/repositories?after=2011-09-30T17%3A50%3A48.936163%2B00%3A00"
            }
            """
        do {
            if let data = jsonString.data(using: .utf8) {
                let repository = try JSONDecoder().decode(BGRepository.self, from: data)
                XCTAssert(repository.pagelen == 10)
                XCTAssert(repository.next == "https://api.bitbucket.org/2.0/repositories?after=2011-09-30T17%3A50%3A48.936163%2B00%3A00")
                XCTAssert(repository.values != nil)
            } else {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    // Test case to test BGValue model class. here i have added few parameters but we can add more parameter in json string to test more edge cases
    func testBGValueModel() throws {
        let jsonString = """
            {
                "scm": "git",
                "website": "http://rubyonrails.org/",
                "has_wiki": false,
                "uuid": "{c34751f8-0c4b-4981-bf96-84de39f91cd9}",
            }
            """
        do {
            if let data = jsonString.data(using: .utf8) {
                let repository = try JSONDecoder().decode(BGValue.self, from: data)
                XCTAssert(repository.website == "http://rubyonrails.org/")
                XCTAssert(repository.uuid == "{c34751f8-0c4b-4981-bf96-84de39f91cd9}")
            } else {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
}
