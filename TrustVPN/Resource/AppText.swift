import Foundation

final class AppText {
    static var dataSecurityLabel: String = "Your data is securely protected according to:"
    static var termsView: String = "Terms of use"
    static var termsLabel: String = "Continuando con el texto que has compartido: cum autem sequi velit esse, et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.\n\nTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt. Este fragmento es de, un texto que se utiliza en diseño gráfico y tipografía como un texto de marcador de posición. Si necesitas algo más o deseas que continúe con otro tema, házmelo saber."
    
    static var termsAcceptButton: String = "Accept and continue"
    static var continueButton: String = "Continue"
    static var onboard1Title: String = "Safeguard your connection"
    static var onboard1SubTitle: String = "Keep your internet activities private. Turn on the VPN to protect your data from hackers and prying eyes"
    static var onboard2Title: String = "Check your passwords"
    static var onboard2SubTitle: String = "Make sure your passwords are strong and secure. Our tool will help you identify weak and vulnerable passwords"
    static var onboard3Title: String = "Finding hidden devices"
    static var onboard3SubTitle: String = "Our universal magnetic radiation scanner, will help you detect all devices in your vicinity whether it's a hidden camera or a lost earpiece"
    static var vpnService: String = "VPN Service"
    static var deviceSearch: String = "Device search"
    static var passwordSecurity: String = "Password security"
    static var options: String = "Options"
    static var serverNotSelected: String = "Server not selected"
    static var serverNotSelectedDescription: String = "Please select a server to connect to the VPN"
    static var selectServer: String = "Select server"
    static var vpnServers: String = "VPN Servers"
    static var select: String = "Select"
    static var added: String = "Added"
    static var connected: String = "Connected"
    static var disconnected: String = "Disconnected"
    static var renameServer: String = "Rename server"
    static var removeServer: String = "Remove from list"
    static var removeDescription: String = "The server will be removed from the list of added servers"
    static var remove: String = "Remove"
    static var renameServerPlaceholder: String = "App Name Server"
    static var cancel: String = "Cancel"
    static var save: String = "Save"
    static var dataIsSecure: String = "Your data is secure. We don’t save or share it"
    static var great: String = "Great! Server added"
    static var permission: String = "When you connect to the VPN, your device will ask for permission to complete the setup process. Please enter your device's password when prompted."
    static var connectionTo: String = "Connection to:"
    static var typePassword: String = "Type a password"
    static var tips: String = "Password security tips"
    static var unsecurePassword: String = "Unsecure password"
    static var mediumPassword: String = "Medium password"
    static var strongPassword: String = "Strong password"
    static var crackedDescriptionLabel: String = "Your password can be cracked in"
    static var howToCreateStrongPasswords: String = "How to Create Strong Passwords"
    static var howToCreateStrongPasswordsDescription: String =
"""
If your password strength rating was not satisfactory, it’s time to create new, more secure passwords. Here are some best practices to follow:
 •  Length Matters: Passwords should be at least 12 characters long, with 16 characters being ideal. Studies show that 45% of Americans use passwords with eight characters or fewer, which are less secure than longer ones.
 •  Use a Mix of Characters: Include a combination of uppercase and lowercase letters, numbers, and special characters in your passwords.
 •  Unique Passwords for Each Account: Avoid using the same password across multiple accounts. Each online account should have its own unique password.
 •  Avoid Personal Information: Do not use easily accessible personal information, such as your birthday, address, or names of children or pets, as these can be exploited in identity theft or data breaches.
 •  No Consecutive Patterns: Steer clear of using consecutive letters or numbers like "ABCD" or "1234" in your passwords.
 •  Avoid Common Passwords: Never use "password" or simple repetitive patterns like "aaaa" or "1111" as your password.
"""
    static var whyIsPasswordSecurityImportant: String = "Why is password security important?"
    static var whyIsPasswordSecurityImportantDescription: String =
"""
Inadequate password security can lead to serious consequences, including but not limited to:
 •  Data Theft: Hackers who gain access to a user’s credentials can log into their accounts to steal personally identifiable information (PII), such as names, addresses, and bank account details. This information can be used to steal money directly or to commit identity theft, which may result in further financial losses or complications in securing loans and employment.
 •  Privacy Invasion: Weak passwords can compromise personal privacy. For instance, failing to change the default password on IP security cameras could allow hackers to access your account and monitor activities inside your home.
 •  Corporate Risks: For businesses, weak password security can lead to breaches where hackers launch disinformation campaigns, leak sensitive data to competitors, or demand ransom for stolen information.
"""
    
    static var howOurToolWorks: String = "How our tool works?"
    static var howOurToolWorksDescription: String =
"""
The Password Protection tool checks user passwords using a special algorithm that calculates password strength based on the characters entered. Keep the following guidelines in mind when creating passwords:

Length: A password should contain at least eight to ten characters, the ideal length is 16-20 characters.
Character combination: A strong password should contain not just a phrase, but a combination of letters, numbers, and symbols. Each character type has its own numerical value, which is summed up to get a total score.
Uniqueness: The password must not contain repeating characters, instead it must use unique combinations.

Using these criteria, the tool calculates a score for each password, which is then translated into the estimated time it would take a computer to crack the password. For example, a password such as “f0JB^B5sjmXl” would take approximately 34 years to crack.
"""
    static var typesOfPasswordAttacks: String = "Types of password attacks"
    static var typesOfPasswordAttacksDescription: String =
"""
There are several main types of password attacks, with the most common being:
 1.  Brute Force Attack: This technique involves trying all possible combinations of characters to crack a password. For example, if a password is two characters long, the attack will try combinations in the following order: "aa", "ab", "ac", and so on, until all possible variations are exhausted. This method requires significant computational resources and time, especially for long and complex passwords, but it guarantees that the password will be cracked if enough time and resources are available.
 2.  Dictionary Attack: Unlike brute force attacks, this method uses a precompiled list of words (dictionaries) to find matches with the password. Such attacks use common passwords, phrases, and known word combinations like "password", "123456", "qwerty", and their variations. This method is faster than brute force as it targets more likely options.
 3.  Rainbow Table Attack: This technique uses precomputed hash values and their corresponding passwords. Hash functions convert passwords into encrypted strings, and if a password's hash matches a hash in the table, the password is considered cracked. This method is effective for cracking weak and reused passwords.
 4.  Social Engineering: This type of attack relies on manipulating people to obtain passwords and other confidential information. It can include phishing, deception, or impersonation to trick the victim into revealing their passwords or personal data.
 5.  Phishing: The attacker creates fake websites or sends fraudulent emails to deceive users into entering their passwords. This data is then used to access accounts.
 6.  Credential Stuffing: This method uses already compromised usernames and passwords to attempt to log into other accounts. This approach is effective against users who use the same password across multiple services.
"""
    
    static var sec: String = "sec"
    static var min: String = "min"
    static var hours: String = "hours"
    static var startScanning: String = "Start scanning"
    static var stop: String = "Stop"
    static var indicator: String = "When a device is detected, the indicator's values will change: the closer you get to the device, the higher the values."
    static var connectionInfo: String = "Connection info"
    static var moreButton: String = "More"
    static var vpnStatus: String = "VPN status"
    static var connectionType: String = "Connection type"
    
    static var additionalSettings: String = "Additional settings"
    static var changeIcon: String = "Change icon"
    static var supportAndFAQ = "Support & FAQ"
    static var privatePolicy: String = "Private policy"
    static var termsOfUse: String = "Terms of Use"
    static var ipAdress: String = "ip addresses"
    static var versionIVP: String = "Version IVP"
    static var asn: String = "ASN"
    static var timeZone: String = "Time Zone"
    static var updateInformation: String = "Update information"
}

