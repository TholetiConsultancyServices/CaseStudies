//
//  Reachability.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation
import SystemConfiguration

struct Reachability {

    var isReachable: Bool {

        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else { return false }

        var flags = SCNetworkReachabilityFlags()
        guard SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) else { return false }

        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }

}
