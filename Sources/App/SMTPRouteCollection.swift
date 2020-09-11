import Vapor

struct SMTPRouteCollection: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        let group = routes.grouped("api", "smtp")
        group.post("send", use: SMTPController.sendEmail)
    }
}
