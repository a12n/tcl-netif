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
            dict set ans $ifnam $ifaddrs
            unset ifnam ifaddrs
        }
    }
    # Remove non-connected interfaces
    set netsh [exec netsh interface ipv4 show interface]
    set state_pat {^\s*\d+\s+\d+\s+\d+\s+(\S+)\s+(.+)$}
    foreach line [split $netsh \n] {
        if {[regexp -line $state_pat $line _ state ifnam]} {
            if {$state ne {connected}} {
                set ans [dict remove $ans $ifnam]
            }
        }
    }
    return $ans
}
