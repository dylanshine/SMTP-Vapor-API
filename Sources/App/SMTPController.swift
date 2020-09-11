import Vapor
import Smtp

enum SMTPController {
    
    static func sendEmail(request: Request) throws -> EventLoopFuture<Response> {
        let email = try request.content.decode(Email.self)
        
        return request.smtp.send(email)
            .flatMap { result in
            switch result {
            case .success:
                return request.eventLoop.makeSucceededFuture(Response(status: .ok))
            case .failure(let error):
                return request.eventLoop.makeFailedFuture(error)
            }
        }
    }
}
