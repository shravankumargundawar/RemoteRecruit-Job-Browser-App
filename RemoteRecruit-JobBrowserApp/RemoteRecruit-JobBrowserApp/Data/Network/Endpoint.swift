import Foundation

enum Endpoint {
    case jobs(limit: Int, offset: Int)
    var url: URL {
        URL(string: "https://himalayas.app/jobs/api?limit=20&offset=0")!
    }
}
