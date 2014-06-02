proc netif {{ifnam {}}} {
    proc parse {ifstr} {
        set pattern {^(\S+).*inet addr:\s*(\S+)}
        if {[regexp $pattern $ifstr _ ifnam ifaddr]} {
            return [list $ifnam $ifaddr]
        } else {
            error {Device has no address}
        }
    }
    proc ssplit {str sep} {
        return [split [string map [list $sep \uFFFF] $str] \uFFFF]
    }
    if {$ifnam eq {}} {
        set ifconfig [exec /sbin/ifconfig]
    } else {
        set ifconfig [exec /sbin/ifconfig $ifnam]
    }
    set ifstrs [ssplit $ifconfig \n\n]
    return [lmap ifstr $ifstrs {parse $ifstr}]
}
