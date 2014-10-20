proc netif {} {
    set netsh [exec netsh interface ipv4 show addresses]
    set ifnam_pat {.*\"([^\"]+)\"$}
    set ifaddr_pat {^\s+(?:IPv4|IP)[ -].*:?\s+([\d\.]+)$}
    set ans [dict create]
    foreach ifstr [_ssplit $netsh \n\n] {
        foreach line [split $ifstr \n] {
            if {[regexp -line $ifnam_pat $line _ ifnam]} {
                # ok
            } elseif {[regexp -line $ifaddr_pat $line _ ifaddr]} {
                lappend ifaddrs $ifaddr
            }
        }
        if {[info exists ifnam] && [info exists ifaddrs]} {
            dict set ans $ifnam addrs $ifaddrs
            unset ifnam ifaddrs
        }
    }
    # Remove non-connected interfaces, get MTU
    set netsh [exec netsh interface ipv4 show interface]
    set pattern {^\s*\d+\s+\d+\s+(\d+)\s+(\S+)\s+(.+)$}
    foreach line [split $netsh \n] {
        if {[regexp -line $pattern $line _ mtu state ifnam]} {
            if {$state eq {connected}} {
                set ans [dict set ans $ifnam mtu $mtu]
            } else {
                set ans [dict remove $ans $ifnam]
            }
        }
    }
    return $ans
}
