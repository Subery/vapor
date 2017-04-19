extension Config {
    /// Adds a configurable Mail instance.
    public func addConfigurable<
        Mail: MailProtocol
    >(mail: Mail, name: String) {
        customAddConfigurable(instance: mail, unique: "mail", name: name)
    }
    
    /// Adds a configurable Mail class.
    public func addConfigurable<
        Mail: MailProtocol & ConfigInitializable
    >(mail: Mail.Type, name: String) {
        customAddConfigurable(class: Mail.self, unique: "mail", name: name)
    }
    
    /// Resolves the configured Mail.
    public func resolveMail() throws -> MailProtocol {
        return try customResolve(
            unique: "mail",
            file: "droplet",
            keyPath: ["mail"],
            as: MailProtocol.self,
            default: UnimplementedMailer.init
        )
    }
}

extension UnimplementedMailer: ConfigInitializable {
    public convenience init(config: Config) throws {
        self.init()
    }
}