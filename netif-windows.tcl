proc netif {{name {}}} {
    set ipconfig [exec ipconfig /all]
    set ifname_pat {^([^:]*(?:Ethernet|PPP)[^:]*):?$}
    set ifaddr_pat {^\s*(?:IPv4|IP)[ -].*:\s*(\S+)}
    set ans {}
    foreach line [split $ipconfig \n] {
        if {[regexp -line $ifname_pat $line _ ifname]} {
            # ok
        } elseif {[regexp -line $ifaddr_pat $line _ ifaddr]} {
            if {[info exists ifname]} {
                lappend ans [list $ifname $ifaddr]
                unset ifaddr ifname
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
