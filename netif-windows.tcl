proc netif {{name {}}} {
    set ipconfig [exec ipconfig /all]
    set ifnam_pat {^([^:]*(?:Ethernet|PPP)[^:]*):?$}
    set ifaddr_pat {^\s*(?:IPv4|IP)[ -].*:\s*(\S+)}
    set ans {}
    foreach line [split $ipconfig \n] {
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
