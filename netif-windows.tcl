proc netif {} {
    set netsh [exec netsh interface ipv4 show addresses]
    set ifnam_pat {.*\"([^\"]+)\"$}
    set ifaddr_pat {^\s+(?:IPv4|IP)[ -].*:?\s+(\d+\.\d+\.\d+\.\d+)$}
    set ans [dict create]
    foreach line [split $netsh \n] {
        if {[regexp -line $ifnam_pat $line _ ifnam]} {
            # ok
        } elseif {[regexp -line $ifaddr_pat $line _ ifaddr]} {
            if {[info exists ifnam]} {
                dict set ans $ifnam $ifaddr
                unset ifaddr ifnam
            }
        }
    }
    return $ans
}
