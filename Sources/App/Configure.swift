import Vapor
import Smtp

// configures your application
public func configure(_ app: Application) throws {
        
    app.smtp.configuration.hostname = "<<HOSTNAME>>"
    app.smtp.configuration.port = 25
    app.smtp.configuration.secure = .ssl
    app.smtp.configuration.username = "<<USERNAME>>"
    app.smtp.configuration.password = "<<PASSWORD>>"

    
    let routeCollection = SMTPRouteCollection()
    try routeCollection.boot(routes: app.routes)
}
