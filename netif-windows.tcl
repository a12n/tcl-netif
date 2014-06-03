proc netif {{name {}}} {
    set netsh [exec netsh interface ipv4 show addresses]
    set ifnam_pat {.*\"([^\"]+)\"$}
    set ifaddr_pat {^\s+(?:IPv4|IP)[ -].*:?\s+(\d+\.\d+\.\d+\.\d+)$}
    set ans {}
    foreach line [split $netsh \n] {
        if {[regexp -line $ifnam_pat $line _ ifnam]} {
            # ok
        } elseif {[regexp -line $ifaddr_pat $line _ ifaddr]} {
            if {[info exists ifnam]} {
                lappend ans [list $ifnam $ifaddr]
                unset ifaddr ifnam
            }
        }
    }
    if {$name ne {}} {
        foreach iface $ans {
            if {[lindex $iface 0] eq $name} {
                return $iface
            }
        }
        error "Device {$name} not found"
    }
    return $ans
}
